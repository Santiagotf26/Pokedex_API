<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pokédex Personal - API PokéAPI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/app.js"></script>
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="mb-4 text-center">Pokédex Personal (PokéAPI)</h1>

    <div class="card mb-4">
        <div class="card-header">Buscar Pokémon en PokéAPI</div>
        <div class="card-body">
            <div class="row g-2 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Nombre o ID</label>
                    <input type="text" id="searchPokemon" class="form-control" placeholder="pikachu, 25...">
                </div>
                <div class="col-md-2">
                    <button id="btnBuscarPokemon" class="btn btn-primary w-100">Buscar</button>
                </div>
            </div>
            <div id="pokemonPreview" class="mt-3" style="display:none;">
                <h5>Resultado PokéAPI</h5>
                <div class="d-flex align-items-center">
                    <img id="previewSprite" src="" alt="sprite" class="me-3" style="width:96px;height:96px;">
                    <div>
                        <p class="mb-1"><strong>Nombre:</strong> <span id="previewNombre"></span></p>
                        <p class="mb-1"><strong>Tipos:</strong> <span id="previewTipos"></span></p>
                        <p class="mb-1"><strong>Stats:</strong> <span id="previewStats"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">Registrar/Editar Pokémon</div>
        <div class="card-body">
            <form id="pokemonForm">
                <input type="hidden" id="id" name="id">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Código Registro *</label>
                        <input type="text" class="form-control" id="codigoRegistro" name="codigoRegistro" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Pokemon ID *</label>
                        <input type="number" class="form-control" id="pokemonId" name="pokemonId" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Nombre *</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Nombre Japonés</label>
                        <input type="text" class="form-control" id="nombreJapones" name="nombreJapones">
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Tipo 1 *</label>
                        <input type="text" class="form-control" id="tipo1" name="tipo1" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Tipo 2</label>
                        <input type="text" class="form-control" id="tipo2" name="tipo2">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Altura (m) *</label>
                        <input type="number" step="0.01" class="form-control" id="altura" name="altura" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Peso (kg) *</label>
                        <input type="number" step="0.01" class="form-control" id="peso" name="peso" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Habilidad 1 *</label>
                        <input type="text" class="form-control" id="habilidad1" name="habilidad1" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Habilidad 2</label>
                        <input type="text" class="form-control" id="habilidad2" name="habilidad2">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Habilidad Oculta</label>
                        <input type="text" class="form-control" id="habilidadOculta" name="habilidadOculta">
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">HP *</label>
                        <input type="number" class="form-control" id="hp" name="hp" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Ataque *</label>
                        <input type="number" class="form-control" id="ataque" name="ataque" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Defensa *</label>
                        <input type="number" class="form-control" id="defensa" name="defensa" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Atq. Esp. *</label>
                        <input type="number" class="form-control" id="ataqueEspecial" name="ataqueEspecial" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Def. Esp. *</label>
                        <input type="number" class="form-control" id="defensaEspecial" name="defensaEspecial" required>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Velocidad *</label>
                        <input type="number" class="form-control" id="velocidad" name="velocidad" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Sprite URL *</label>
                        <input type="text" class="form-control" id="spriteUrl" name="spriteUrl" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Nombre Entrenador *</label>
                        <input type="text" class="form-control" id="nombreEntrenador" name="nombreEntrenador" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Email Entrenador *</label>
                        <input type="email" class="form-control" id="emailEntrenador" name="emailEntrenador" required>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Apodo</label>
                        <input type="text" class="form-control" id="apodo" name="apodo">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Nivel *</label>
                        <input type="number" class="form-control" id="nivel" name="nivel" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Capturado *</label>
                        <select id="esCapturado" name="esCapturado" class="form-select" required>
                            <option value="true" selected>Sí</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Captura</label>
                        <input type="date" class="form-control" id="fechaCaptura" name="fechaCaptura">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Observaciones</label>
                        <textarea class="form-control" id="observaciones" name="observaciones" rows="2"></textarea>
                    </div>

                    <div class="col-12 text-end">
                        <button type="button" id="btnLimpiar" class="btn btn-secondary me-2">Limpiar</button>
                        <button type="submit" class="btn btn-success" id="btnGuardar">Guardar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Pokédex Registrada</span>
            <div class="d-flex align-items-center">
                <input type="text" id="searchLocal" class="form-control form-control-sm me-2" placeholder="Buscar...">
                <button id="btnRefrescar" class="btn btn-sm btn-outline-primary">Refrescar</button>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaPokemon" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Apodo</th>
                        <th>Entrenador</th>
                        <th>Nivel</th>
                        <th>Capturado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
