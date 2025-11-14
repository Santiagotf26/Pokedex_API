package sena.adso.dao;

import sena.adso.model.PokemonRecord;
import sena.adso.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PokemonRecordDAOImpl implements PokemonRecordDAO {

    private PokemonRecord mapRow(ResultSet rs) throws SQLException {
        PokemonRecord p = new PokemonRecord();
        p.setId(rs.getInt("id"));
        p.setCodigoRegistro(rs.getString("codigo_registro"));
        p.setPokemonId(rs.getInt("pokemon_id"));
        p.setNombre(rs.getString("nombre"));
        p.setNombreJapones(rs.getString("nombre_japones"));
        p.setTipo1(rs.getString("tipo1"));
        p.setTipo2(rs.getString("tipo2"));
        p.setAltura(rs.getDouble("altura"));
        p.setPeso(rs.getDouble("peso"));
        p.setHabilidad1(rs.getString("habilidad1"));
        p.setHabilidad2(rs.getString("habilidad2"));
        p.setHabilidadOculta(rs.getString("habilidad_oculta"));
        p.setHp(rs.getInt("hp"));
        p.setAtaque(rs.getInt("ataque"));
        p.setDefensa(rs.getInt("defensa"));
        p.setAtaqueEspecial(rs.getInt("ataque_especial"));
        p.setDefensaEspecial(rs.getInt("defensa_especial"));
        p.setVelocidad(rs.getInt("velocidad"));
        p.setSpriteUrl(rs.getString("sprite_url"));
        p.setNombreEntrenador(rs.getString("nombre_entrenador"));
        p.setEmailEntrenador(rs.getString("email_entrenador"));
        p.setApodo(rs.getString("apodo"));
        p.setNivel(rs.getInt("nivel"));
        p.setEsCapturado(rs.getBoolean("es_capturado"));
        Date fc = rs.getDate("fecha_captura");
        p.setFechaCaptura(fc != null ? fc.toLocalDate() : null);
        p.setObservaciones(rs.getString("observaciones"));
        return p;
    }

    @Override
    public List<PokemonRecord> getAll() {
        List<PokemonRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM pokemon_record ORDER BY id DESC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public PokemonRecord getById(int id) {
        String sql = "SELECT * FROM pokemon_record WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<PokemonRecord> search(String query) {
        List<PokemonRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM pokemon_record WHERE nombre LIKE ? OR apodo LIKE ? OR nombre_entrenador LIKE ? ORDER BY id DESC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean create(PokemonRecord p) {
        String sql = "INSERT INTO pokemon_record (codigo_registro, pokemon_id, nombre, nombre_japones, tipo1, tipo2, altura, peso, habilidad1, habilidad2, habilidad_oculta, hp, ataque, defensa, ataque_especial, defensa_especial, velocidad, sprite_url, nombre_entrenador, email_entrenador, apodo, nivel, es_capturado, fecha_captura, observaciones) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getCodigoRegistro());
            ps.setInt(2, p.getPokemonId());
            ps.setString(3, p.getNombre());
            ps.setString(4, p.getNombreJapones());
            ps.setString(5, p.getTipo1());
            ps.setString(6, p.getTipo2());
            ps.setDouble(7, p.getAltura());
            ps.setDouble(8, p.getPeso());
            ps.setString(9, p.getHabilidad1());
            ps.setString(10, p.getHabilidad2());
            ps.setString(11, p.getHabilidadOculta());
            ps.setInt(12, p.getHp());
            ps.setInt(13, p.getAtaque());
            ps.setInt(14, p.getDefensa());
            ps.setInt(15, p.getAtaqueEspecial());
            ps.setInt(16, p.getDefensaEspecial());
            ps.setInt(17, p.getVelocidad());
            ps.setString(18, p.getSpriteUrl());
            ps.setString(19, p.getNombreEntrenador());
            ps.setString(20, p.getEmailEntrenador());
            ps.setString(21, p.getApodo());
            ps.setInt(22, p.getNivel());
            ps.setBoolean(23, p.getEsCapturado() != null ? p.getEsCapturado() : Boolean.TRUE);
            if (p.getFechaCaptura() != null) {
                ps.setDate(24, java.sql.Date.valueOf(p.getFechaCaptura()));
            } else {
                ps.setNull(24, Types.DATE);
            }
            ps.setString(25, p.getObservaciones());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        p.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(PokemonRecord p) {
        String sql = "UPDATE pokemon_record SET codigo_registro=?, pokemon_id=?, nombre=?, nombre_japones=?, tipo1=?, tipo2=?, altura=?, peso=?, habilidad1=?, habilidad2=?, habilidad_oculta=?, hp=?, ataque=?, defensa=?, ataque_especial=?, defensa_especial=?, velocidad=?, sprite_url=?, nombre_entrenador=?, email_entrenador=?, apodo=?, nivel=?, es_capturado=?, fecha_captura=?, observaciones=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getCodigoRegistro());
            ps.setInt(2, p.getPokemonId());
            ps.setString(3, p.getNombre());
            ps.setString(4, p.getNombreJapones());
            ps.setString(5, p.getTipo1());
            ps.setString(6, p.getTipo2());
            ps.setDouble(7, p.getAltura());
            ps.setDouble(8, p.getPeso());
            ps.setString(9, p.getHabilidad1());
            ps.setString(10, p.getHabilidad2());
            ps.setString(11, p.getHabilidadOculta());
            ps.setInt(12, p.getHp());
            ps.setInt(13, p.getAtaque());
            ps.setInt(14, p.getDefensa());
            ps.setInt(15, p.getAtaqueEspecial());
            ps.setInt(16, p.getDefensaEspecial());
            ps.setInt(17, p.getVelocidad());
            ps.setString(18, p.getSpriteUrl());
            ps.setString(19, p.getNombreEntrenador());
            ps.setString(20, p.getEmailEntrenador());
            ps.setString(21, p.getApodo());
            ps.setInt(22, p.getNivel());
            ps.setBoolean(23, p.getEsCapturado() != null ? p.getEsCapturado() : Boolean.TRUE);
            if (p.getFechaCaptura() != null) {
                ps.setDate(24, java.sql.Date.valueOf(p.getFechaCaptura()));
            } else {
                ps.setNull(24, Types.DATE);
            }
            ps.setString(25, p.getObservaciones());
            ps.setInt(26, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM pokemon_record WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
