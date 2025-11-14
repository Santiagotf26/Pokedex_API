package sena.adso.dao;

import sena.adso.model.PokemonRecord;
import java.util.List;

public interface PokemonRecordDAO {
    List<PokemonRecord> getAll();
    PokemonRecord getById(int id);
    List<PokemonRecord> search(String query);
    boolean create(PokemonRecord entity);
    boolean update(PokemonRecord entity);
    boolean delete(int id);
}
