package sena.adso.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import sena.adso.dao.PokemonRecordDAO;
import sena.adso.dao.PokemonRecordDAOImpl;
import sena.adso.model.PokemonRecord;
import sena.adso.util.LocalDateAdapter;
import sena.adso.util.LocalDateTimeAdapter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "PokemonServlet", urlPatterns = {"/pokemon"})
public class PokemonServlet extends HttpServlet {

    private PokemonRecordDAO dao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        dao = new PokemonRecordDAOImpl();
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "getAll";
        }
        Map<String, Object> res = new HashMap<>();
        try (PrintWriter out = response.getWriter()) {
            switch (action) {
                case "getAll": {
                    List<PokemonRecord> list = dao.getAll();
                    res.put("success", true);
                    res.put("data", list);
                    break;
                }
                case "getById": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    PokemonRecord p = dao.getById(id);
                    res.put("success", p != null);
                    res.put("data", p);
                    break;
                }
                case "search": {
                    String q = request.getParameter("query");
                    List<PokemonRecord> list = dao.search(q != null ? q : "");
                    res.put("success", true);
                    res.put("data", list);
                    break;
                }
                case "getExternal": {
                    String param = request.getParameter("param");
                    res = consumePokeApi(param);
                    break;
                }
                default: {
                    res.put("success", false);
                    res.put("message", "Acción no soportada");
                }
            }
            out.print(gson.toJson(res));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "create";
        }
        Map<String, Object> res = new HashMap<>();
        try (PrintWriter out = response.getWriter()) {
            switch (action) {
                case "create":
                    PokemonRecord nuevo = buildFromRequest(request);
                    boolean created = dao.create(nuevo);
                    res.put("success", created);
                    res.put("data", nuevo);
                    break;
                case "update":
                    int id = Integer.parseInt(request.getParameter("id"));
                    PokemonRecord existente = buildFromRequest(request);
                    existente.setId(id);
                    boolean updated = dao.update(existente);
                    res.put("success", updated);
                    res.put("data", existente);
                    break;
                default:
                    res.put("success", false);
                    res.put("message", "Acción POST no soportada");
            }
            out.print(gson.toJson(res));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> res = new HashMap<>();
        try (PrintWriter out = response.getWriter()) {
            String idParam = request.getParameter("id");
            if (idParam == null) {
                res.put("success", false);
                res.put("message", "Parámetro id es obligatorio");
            } else {
                int id = Integer.parseInt(idParam);
                boolean deleted = dao.delete(id);
                res.put("success", deleted);
            }
            out.print(gson.toJson(res));
        }
    }

    private PokemonRecord buildFromRequest(HttpServletRequest request) {
        PokemonRecord p = new PokemonRecord();
        p.setCodigoRegistro(request.getParameter("codigoRegistro"));
        p.setPokemonId(Integer.parseInt(request.getParameter("pokemonId")));
        p.setNombre(request.getParameter("nombre"));
        p.setNombreJapones(request.getParameter("nombreJapones"));
        p.setTipo1(request.getParameter("tipo1"));
        p.setTipo2(request.getParameter("tipo2"));
        p.setAltura(Double.parseDouble(request.getParameter("altura")));
        p.setPeso(Double.parseDouble(request.getParameter("peso")));
        p.setHabilidad1(request.getParameter("habilidad1"));
        p.setHabilidad2(request.getParameter("habilidad2"));
        p.setHabilidadOculta(request.getParameter("habilidadOculta"));
        p.setHp(Integer.parseInt(request.getParameter("hp")));
        p.setAtaque(Integer.parseInt(request.getParameter("ataque")));
        p.setDefensa(Integer.parseInt(request.getParameter("defensa")));
        p.setAtaqueEspecial(Integer.parseInt(request.getParameter("ataqueEspecial")));
        p.setDefensaEspecial(Integer.parseInt(request.getParameter("defensaEspecial")));
        p.setVelocidad(Integer.parseInt(request.getParameter("velocidad")));
        p.setSpriteUrl(request.getParameter("spriteUrl"));
        p.setNombreEntrenador(request.getParameter("nombreEntrenador"));
        p.setEmailEntrenador(request.getParameter("emailEntrenador"));
        p.setApodo(request.getParameter("apodo"));
        p.setNivel(Integer.parseInt(request.getParameter("nivel")));
        p.setEsCapturado(Boolean.parseBoolean(request.getParameter("esCapturado")));
        String fechaCaptura = request.getParameter("fechaCaptura");
        if (fechaCaptura != null && !fechaCaptura.isEmpty()) {
            p.setFechaCaptura(java.time.LocalDate.parse(fechaCaptura));
        }
        p.setObservaciones(request.getParameter("observaciones"));
        p.setFechaRegistro(LocalDateTime.now());
        return p;
    }

    private Map<String, Object> consumePokeApi(String param) {
        Map<String, Object> res = new HashMap<>();
        if (param == null || param.trim().isEmpty()) {
            res.put("success", false);
            res.put("message", "Parámetro de búsqueda vacío");
            return res;
        }
        String urlStr = "https://pokeapi.co/api/v2/pokemon/" + param.toLowerCase();
        HttpURLConnection conn = null;
        try {
            URL url = new URL(urlStr);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            int status = conn.getResponseCode();
            if (status != 200) {
                res.put("success", false);
                res.put("message", "Error al consultar PokéAPI: " + status);
                return res;
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();
            Map data = gson.fromJson(response.toString(), Map.class);
            res.put("success", true);
            res.put("data", data);
        } catch (IOException e) {
            e.printStackTrace();
            res.put("success", false);
            res.put("message", "Error al conectar con PokéAPI");
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        return res;
    }
}
