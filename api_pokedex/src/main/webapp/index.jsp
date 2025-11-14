<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pokédex Personal - API PokéAPI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        :root {
            --primary-red: #d62828;
            --primary-orange: #f77f00;
            --primary-yellow: #ffde59;
            --primary-blue: #003049;
            --light-bg: #f8f9fa;
        }
        
        body {
            background: radial-gradient(circle at top, var(--primary-yellow) 0, #f2f2f2 40%, #e3e3e3 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .pokedex-header {
            background: linear-gradient(90deg, var(--primary-red), var(--primary-orange));
            color: #fff;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,.25);
            position: relative;
            overflow: hidden;
        }
        
        .pokedex-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100" opacity="0.1"><circle cx="50" cy="50" r="40" stroke="white" stroke-width="2" fill="none" /></svg>');
        }
        
        .pokedex-header .circle {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 30%, #ffffff, #4ea8de);
            border: 4px solid #f1f1f1;
            box-shadow: 0 0 0 4px var(--primary-blue);
            position: relative;
            z-index: 1;
        }
        
        .pokedex-card {
            border-radius: 1rem;
            box-shadow: 0 0.25rem 1rem rgba(0,0,0,.15);
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .pokedex-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,.2);
        }
        
        .badge-type {
            text-transform: uppercase;
            margin-right: .25rem;
            font-size: 0.75rem;
            padding: 0.35em 0.65em;
        }
        
        .table thead {
            background-color: var(--primary-blue);
            color: #fff;
        }
        
        .sprite-preview {
            width: 96px;
            height: 96px;
            image-rendering: pixelated;
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 5px;
        }
        
        .form-control, .form-select {
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-orange);
            box-shadow: 0 0 0 0.25rem rgba(247, 127, 0, 0.25);
        }
        
        .btn {
            border-radius: 0.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-danger {
            background-color: var(--primary-red);
            border-color: var(--primary-red);
        }
        
        .btn-danger:hover {
            background-color: #b02121;
            border-color: #b02121;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background-color: var(--primary-orange);
            border-color: var(--primary-orange);
            color: white;
        }
        
        .btn-warning:hover {
            background-color: #e67300;
            border-color: #e67300;
            color: white;
            transform: translateY(-2px);
        }
        
        .card-header {
            border-radius: 1rem 1rem 0 0 !important;
            font-weight: 700;
            padding: 1rem 1.25rem;
        }
        
        .section-title {
            color: var(--primary-blue);
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-red), var(--primary-orange));
            border-radius: 3px;
        }
        
        .stats-container {
            background-color: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .stat-bar {
            height: 8px;
            background-color: #e9ecef;
            border-radius: 4px;
            margin-bottom: 0.5rem;
            overflow: hidden;
        }
        
        .stat-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-red), var(--primary-orange));
            border-radius: 4px;
        }
        
        .action-buttons .btn {
            margin-right: 0.25rem;
            margin-bottom: 0.25rem;
        }
        
        .pokemon-preview-card {
            border: 2px dashed #dee2e6;
            border-radius: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .pokemon-preview-card:hover {
            border-color: var(--primary-orange);
        }
        
        @media (max-width: 768px) {
            .pokedex-header .circle {
                width: 45px;
                height: 45px;
            }
            
            .btn {
                padding: 0.5rem 1rem;
            }
        }
    </style>
    <script src="js/app.js"></script>
</head>
<body>
<div class="container py-4">

    <div class="pokedex-header mb-4 p-3 d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <div class="circle me-3"></div>
            <div>
                <h1 class="h3 mb-0 fw-bold">Pokédex Personal</h1>
                <small class="d-flex align-items-center"><i class="fas fa-database me-1"></i> Consumo de PokéAPI + CRUD en MySQL</small>
            </div>
        </div>
        <div class="text-end d-none d-md-block">
            <span class="badge bg-light text-dark"><i class="fas fa-graduation-cap me-1"></i> ADSO · API Pública</span>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-lg-4">
            <div class="card pokedex-card h-100">
                <div class="card-header bg-warning text-white d-flex align-items-center">
                    <i class="fas fa-search me-2"></i> Buscar Pokémon (PokéAPI)
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nombre o ID</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                            <input type="text" id="searchPokemon" class="form-control" placeholder="Ej: pikachu, 25, charmander...">
                        </div>
                    </div>
                    <button id="btnBuscarPokemon" class="btn btn-danger w-100 mb-3">
                        <i class="fas fa-search me-1"></i> Buscar en PokéAPI
                    </button>
                    <div id="pokemonPreview" class="pokemon-preview-card p-3 bg-light" style="display:none;">
                        <div class="d-flex align-items-center">
                            <img id="previewSprite" class="sprite-preview me-3" src="" alt="Sprite del Pokémon">
                            <div class="flex-grow-1">
                                <h5 class="mb-1 fw-bold" id="previewNombre"></h5>
                                <p class="mb-1 small"><strong>Tipos:</strong> <span id="previewTipos"></span></p>
                                <p class="mb-0 small"><strong>Estadísticas:</strong> <span id="previewStats"></span></p>
                            </div>
                        </div>
                        <div class="stats-container mt-2">
                            <h6 class="fw-semibold">Estadísticas Base</h6>
                            <div id="previewStatBars"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card pokedex-card h-100">
                <div class="card-header bg-primary text-white d-flex align-items-center">
                    <i class="fas fa-edit me-2"></i> Registrar / Editar Pokémon
                </div>
                <div class="card-body">
                    <form id="pokemonForm">
                        <input type="hidden" id="id" name="id">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Código Registro *</label>
                                <input type="text" class="form-control" id="codigoRegistro" name="codigoRegistro" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Pokémon ID *</label>
                                <input type="number" class="form-control" id="pokemonId" name="pokemonId" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Nombre *</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Nombre Japonés</label>
                                <input type="text" class="form-control" id="nombreJapones" name="nombreJapones">
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Tipo 1 *</label>
                                <input type="text" class="form-control" id="tipo1" name="tipo1" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Tipo 2</label>
                                <input type="text" class="form-control" id="tipo2" name="tipo2">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Altura (m) *</label>
                                <input type="number" step="0.01" class="form-control" id="altura" name="altura" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Peso (kg) *</label>
                                <input type="number" step="0.01" class="form-control" id="peso" name="peso" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Habilidad 1 *</label>
                                <input type="text" class="form-control" id="habilidad1" name="habilidad1" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Habilidad 2</label>
                                <input type="text" class="form-control" id="habilidad2" name="habilidad2">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Habilidad Oculta</label>
                                <input type="text" class="form-control" id="habilidadOculta" name="habilidadOculta">
                            </div>

                            <div class="col-md-2">
                                <label class="form-label fw-semibold">PS *</label>
                                <input type="number" class="form-control" id="hp" name="hp" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Ataque *</label>
                                <input type="number" class="form-control" id="ataque" name="ataque" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Defensa *</label>
                                <input type="number" class="form-control" id="defensa" name="defensa" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Atq. Esp. *</label>
                                <input type="number" class="form-control" id="ataqueEspecial" name="ataqueEspecial" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Def. Esp. *</label>
                                <input type="number" class="form-control" id="defensaEspecial" name="defensaEspecial" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Velocidad *</label>
                                <input type="number" class="form-control" id="velocidad" name="velocidad" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Sprite URL *</label>
                                <input type="text" class="form-control" id="spriteUrl" name="spriteUrl" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Nombre Entrenador *</label>
                                <input type="text" class="form-control" id="nombreEntrenador" name="nombreEntrenador" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Email Entrenador *</label>
                                <input type="email" class="form-control" id="emailEntrenador" name="emailEntrenador" required>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Apodo</label>
                                <input type="text" class="form-control" id="apodo" name="apodo">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Nivel *</label>
                                <input type="number" class="form-control" id="nivel" name="nivel" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Capturado *</label>
                                <select id="esCapturado" name="esCapturado" class="form-select" required>
                                    <option value="true" selected>Sí</option>
                                    <option value="false">No</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Fecha Captura</label>
                                <input type="date" class="form-control" id="fechaCaptura" name="fechaCaptura">
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-semibold">Observaciones</label>
                                <textarea class="form-control" id="observaciones" name="observaciones" rows="2"></textarea>
                            </div>

                            <div class="col-12 text-end">
                                <button type="button" id="btnLimpiar" class="btn btn-secondary me-2">
                                    <i class="fas fa-broom me-1"></i> Limpiar
                                </button>
                                <button type="submit" class="btn btn-success" id="btnGuardar">
                                    <i class="fas fa-save me-1"></i> Guardar
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="card pokedex-card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <span class="d-flex align-items-center">
                <i class="fas fa-table me-2"></i> Pokédex Registrada
            </span>
            <div class="d-flex align-items-center">
                <div class="input-group input-group-sm me-2" style="width: 200px;">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                    <input type="text" id="searchLocal" class="form-control" placeholder="Buscar en la tabla...">
                </div>
                <button id="btnRefrescar" class="btn btn-sm btn-outline-light">
                    <i class="fas fa-sync-alt me-1"></i> Actualizar
                </button>
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