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
    <style>
        :root {
            --pokemon-red: #e3350d;
            --pokemon-blue: #30a7d7;
            --pokemon-yellow: #ffcb05;
            --pokemon-orange: #ee6b2f;
            --pokemon-green: #4dad5b;
        }
        
        body {
            background: linear-gradient(135deg, #30a7d7 0%, #e3350d 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffcb05' fill-opacity='0.05' fill-rule='evenodd'/%3E%3C/svg%3E");
            z-index: -1;
        }
        
        .container {
            position: relative;
            z-index: 1;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.95);
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--pokemon-red) 0%, var(--pokemon-orange) 100%);
            color: white;
            font-weight: bold;
            border-bottom: none;
            padding: 15px 20px;
            font-size: 1.2rem;
        }
        
        h1 {
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        
        h1::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 4px;
            background: var(--pokemon-yellow);
            border-radius: 2px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--pokemon-blue) 0%, #1b82b1 100%);
            border: none;
            border-radius: 50px;
            font-weight: bold;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #1b82b1 0%, var(--pokemon-blue) 100%);
            transform: scale(1.05);
        }
        
        .btn-success {
            background: linear-gradient(135deg, var(--pokemon-green) 0%, #3a8c47 100%);
            border: none;
            border-radius: 50px;
            font-weight: bold;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #3a8c47 0%, var(--pokemon-green) 100%);
            transform: scale(1.05);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            border-radius: 50px;
            font-weight: bold;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #6c757d 100%);
            transform: scale(1.05);
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--pokemon-blue);
            box-shadow: 0 0 0 0.25rem rgba(48, 167, 215, 0.25);
        }
        
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        
        .table thead th {
            background: linear-gradient(135deg, var(--pokemon-blue) 0%, #1b82b1 100%);
            color: white;
            border: none;
            padding: 15px;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background-color: rgba(48, 167, 215, 0.1);
        }
        
        .table tbody td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        
        #pokemonPreview {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 15px;
            border-left: 5px solid var(--pokemon-yellow);
        }
        
        .badge-type {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            color: white;
            font-weight: bold;
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        .type-normal { background-color: #A8A878; }
        .type-fire { background-color: #F08030; }
        .type-water { background-color: #6890F0; }
        .type-electric { background-color: #F8D030; }
        .type-grass { background-color: #78C850; }
        .type-ice { background-color: #98D8D8; }
        .type-fighting { background-color: #C03028; }
        .type-poison { background-color: #A040A0; }
        .type-ground { background-color: #E0C068; }
        .type-flying { background-color: #A890F0; }
        .type-psychic { background-color: #F85888; }
        .type-bug { background-color: #A8B820; }
        .type-rock { background-color: #B8A038; }
        .type-ghost { background-color: #705898; }
        .type-dragon { background-color: #7038F8; }
        .type-dark { background-color: #705848; }
        .type-steel { background-color: #B8B8D0; }
        .type-fairy { background-color: #EE99AC; }
        
        .pokeball-icon {
            display: inline-block;
            width: 20px;
            height: 20px;
            background: linear-gradient(135deg, var(--pokemon-red) 0%, var(--pokemon-orange) 100%);
            border-radius: 50%;
            margin-right: 5px;
            position: relative;
        }
        
        .pokeball-icon::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background: white;
            transform: translateY(-50%);
        }
        
        .pokeball-icon::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 6px;
            height: 6px;
            background: white;
            border-radius: 50%;
            transform: translate(-50%, -50%);
            z-index: 1;
        }
        
        .stats-bar {
            height: 8px;
            border-radius: 4px;
            background-color: #e9ecef;
            margin-bottom: 5px;
            overflow: hidden;
        }
        
        .stats-fill {
            height: 100%;
            border-radius: 4px;
        }
        
        .hp-fill { background-color: #ff6b6b; width: 45%; }
        .attack-fill { background-color: #feca57; width: 49%; }
        .defense-fill { background-color: #48dbfb; width: 43%; }
        .special-attack-fill { background-color: #ff9ff3; width: 65%; }
        .special-defense-fill { background-color: #1dd1a1; width: 65%; }
        .speed-fill { background-color: #f368e0; width: 45%; }
        
        .action-btn {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.85rem;
            margin-right: 5px;
        }
        
        @media (max-width: 768px) {
            .card-header {
                font-size: 1rem;
                padding: 12px 15px;
            }
            
            h1 {
                font-size: 1.8rem;
            }
            
            .btn-primary, .btn-success, .btn-secondary {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="mb-4 text-center">Pokédex Personal (PokéAPI)</h1>

    <div class="card mb-4">
        <div class="card-header">
            <span class="pokeball-icon"></span>
            Buscar Pokémon en PokéAPI
        </div>
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
        <div class="card-header">
            <span class="pokeball-icon"></span>
            Registrar/Editar Pokémon
        </div>
        <div class="card-body">
            <form id="pokemonForm">
                <input type="hidden" id="id" name="id">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Código Registro *</label>
                        <input type="text" class="form-control" id="codigoRegistro" name="codigoRegistro" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Pokémon ID *</label>
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
            <span><span class="pokeball-icon"></span> Pokédex Registrada</span>
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

<script src="js/app.js"></script>
</body>
</html>