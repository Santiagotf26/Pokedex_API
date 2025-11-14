package sena.adso.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class PokemonRecord implements Serializable {

    private Integer id;
    private String codigoRegistro;
    private Integer pokemonId;
    private String nombre;
    private String nombreJapones;
    private String tipo1;
    private String tipo2;
    private Double altura;
    private Double peso;
    private String habilidad1;
    private String habilidad2;
    private String habilidadOculta;
    private Integer hp;
    private Integer ataque;
    private Integer defensa;
    private Integer ataqueEspecial;
    private Integer defensaEspecial;
    private Integer velocidad;
    private String spriteUrl;
    private String nombreEntrenador;
    private String emailEntrenador;
    private String apodo;
    private Integer nivel;
    private Boolean esCapturado;
    private LocalDate fechaCaptura;
    private String observaciones;
    private LocalDateTime fechaRegistro;

    public PokemonRecord() {
    }

    public PokemonRecord(Integer id, String codigoRegistro, Integer pokemonId, String nombre, String nombreJapones,
                         String tipo1, String tipo2, Double altura, Double peso, String habilidad1, String habilidad2,
                         String habilidadOculta, Integer hp, Integer ataque, Integer defensa, Integer ataqueEspecial,
                         Integer defensaEspecial, Integer velocidad, String spriteUrl, String nombreEntrenador,
                         String emailEntrenador, String apodo, Integer nivel, Boolean esCapturado,
                         LocalDate fechaCaptura, String observaciones, LocalDateTime fechaRegistro) {
        this.id = id;
        this.codigoRegistro = codigoRegistro;
        this.pokemonId = pokemonId;
        this.nombre = nombre;
        this.nombreJapones = nombreJapones;
        this.tipo1 = tipo1;
        this.tipo2 = tipo2;
        this.altura = altura;
        this.peso = peso;
        this.habilidad1 = habilidad1;
        this.habilidad2 = habilidad2;
        this.habilidadOculta = habilidadOculta;
        this.hp = hp;
        this.ataque = ataque;
        this.defensa = defensa;
        this.ataqueEspecial = ataqueEspecial;
        this.defensaEspecial = defensaEspecial;
        this.velocidad = velocidad;
        this.spriteUrl = spriteUrl;
        this.nombreEntrenador = nombreEntrenador;
        this.emailEntrenador = emailEntrenador;
        this.apodo = apodo;
        this.nivel = nivel;
        this.esCapturado = esCapturado;
        this.fechaCaptura = fechaCaptura;
        this.observaciones = observaciones;
        this.fechaRegistro = fechaRegistro;
    }

    // Getters y Setters
    // (mantengo todos los métodos estándar)

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCodigoRegistro() { return codigoRegistro; }
    public void setCodigoRegistro(String codigoRegistro) { this.codigoRegistro = codigoRegistro; }

    public Integer getPokemonId() { return pokemonId; }
    public void setPokemonId(Integer pokemonId) { this.pokemonId = pokemonId; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getNombreJapones() { return nombreJapones; }
    public void setNombreJapones(String nombreJapones) { this.nombreJapones = nombreJapones; }

    public String getTipo1() { return tipo1; }
    public void setTipo1(String tipo1) { this.tipo1 = tipo1; }

    public String getTipo2() { return tipo2; }
    public void setTipo2(String tipo2) { this.tipo2 = tipo2; }

    public Double getAltura() { return altura; }
    public void setAltura(Double altura) { this.altura = altura; }

    public Double getPeso() { return peso; }
    public void setPeso(Double peso) { this.peso = peso; }

    public String getHabilidad1() { return habilidad1; }
    public void setHabilidad1(String habilidad1) { this.habilidad1 = habilidad1; }

    public String getHabilidad2() { return habilidad2; }
    public void setHabilidad2(String habilidad2) { this.habilidad2 = habilidad2; }

    public String getHabilidadOculta() { return habilidadOculta; }
    public void setHabilidadOculta(String habilidadOculta) { this.habilidadOculta = habilidadOculta; }

    public Integer getHp() { return hp; }
    public void setHp(Integer hp) { this.hp = hp; }

    public Integer getAtaque() { return ataque; }
    public void setAtaque(Integer ataque) { this.ataque = ataque; }

    public Integer getDefensa() { return defensa; }
    public void setDefensa(Integer defensa) { this.defensa = defensa; }

    public Integer getAtaqueEspecial() { return ataqueEspecial; }
    public void setAtaqueEspecial(Integer ataqueEspecial) { this.ataqueEspecial = ataqueEspecial; }

    public Integer getDefensaEspecial() { return defensaEspecial; }
    public void setDefensaEspecial(Integer defensaEspecial) { this.defensaEspecial = defensaEspecial; }

    public Integer getVelocidad() { return velocidad; }
    public void setVelocidad(Integer velocidad) { this.velocidad = velocidad; }

    public String getSpriteUrl() { return spriteUrl; }
    public void setSpriteUrl(String spriteUrl) { this.spriteUrl = spriteUrl; }

    public String getNombreEntrenador() { return nombreEntrenador; }
    public void setNombreEntrenador(String nombreEntrenador) { this.nombreEntrenador = nombreEntrenador; }

    public String getEmailEntrenador() { return emailEntrenador; }
    public void setEmailEntrenador(String emailEntrenador) { this.emailEntrenador = emailEntrenador; }

    public String getApodo() { return apodo; }
    public void setApodo(String apodo) { this.apodo = apodo; }

    public Integer getNivel() { return nivel; }
    public void setNivel(Integer nivel) { this.nivel = nivel; }

    public Boolean getEsCapturado() { return esCapturado; }
    public void setEsCapturado(Boolean esCapturado) { this.esCapturado = esCapturado; }

    public LocalDate getFechaCaptura() { return fechaCaptura; }
    public void setFechaCaptura(LocalDate fechaCaptura) { this.fechaCaptura = fechaCaptura; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDateTime fechaRegistro) { this.fechaRegistro = fechaRegistro; }

    @Override
    public String toString() {
        return "PokemonRecord{" +
                "id=" + id +
                ", codigoRegistro='" + codigoRegistro + '\'' +
                ", pokemonId=" + pokemonId +
                ", nombre='" + nombre + '\'' +
                ", nombreJapones='" + nombreJapones + '\'' +
                ", tipo1='" + tipo1 + '\'' +
                ", tipo2='" + tipo2 + '\'' +
                ", altura=" + altura +
                ", peso=" + peso +
                ", habilidad1='" + habilidad1 + '\'' +
                ", habilidad2='" + habilidad2 + '\'' +
                ", habilidadOculta='" + habilidadOculta + '\'' +
                ", hp=" + hp +
                ", ataque=" + ataque +
                ", defensa=" + defensa +
                ", ataqueEspecial=" + ataqueEspecial +
                ", defensaEspecial=" + defensaEspecial +
                ", velocidad=" + velocidad +
                ", spriteUrl='" + spriteUrl + '\'' +
                ", nombreEntrenador='" + nombreEntrenador + '\'' +
                ", emailEntrenador='" + emailEntrenador + '\'' +
                ", apodo='" + apodo + '\'' +
                ", nivel=" + nivel +
                ", esCapturado=" + esCapturado +
                ", fechaCaptura=" + fechaCaptura +
                ", observaciones='" + observaciones + '\'' +
                ", fechaRegistro=" + fechaRegistro +
                '}';
    }
}
