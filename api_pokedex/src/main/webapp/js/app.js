$(document).ready(function () {
    let tabla = $('#tablaPokemon').DataTable({
        language: { url: 'https://cdn.datatables.net/plug-ins/1.13.8/i18n/es-ES.json' },
        columns: [
            { data: 'id' },
            { data: 'codigoRegistro' },
            { data: 'nombre' },
            { data: 'apodo' },
            { data: 'nombreEntrenador' },
            { data: 'nivel' },
            {
                data: 'esCapturado',
                render: function (data) {
                    return data ? 'Sí' : 'No';
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                        <button class="btn btn-sm btn-primary btn-editar" data-id="${row.id}">Editar</button>
                        <button class="btn btn-sm btn-danger btn-eliminar" data-id="${row.id}">Eliminar</button>
                    `;
                },
                orderable: false
            }
        ]
    });

    function cargarTabla() {
        $.getJSON('pokemon', { action: 'getAll' }, function (res) {
            if (res.success) {
                tabla.clear();
                tabla.rows.add(res.data).draw();
            }
        });
    }

    cargarTabla();

    $('#btnRefrescar').click(cargarTabla);

    $('#searchLocal').on('keyup', function () {
        tabla.search(this.value).draw();
    });

    $('#btnLimpiar').click(function () {
        $('#pokemonForm')[0].reset();
        $('#id').val('');
    });

    function validarFormulario() {
        const obligatorios = ['#codigoRegistro', '#pokemonId', '#nombre', '#tipo1', '#altura', '#peso', '#habilidad1', '#hp', '#ataque', '#defensa', '#ataqueEspecial', '#defensaEspecial', '#velocidad', '#spriteUrl', '#nombreEntrenador', '#emailEntrenador', '#nivel'];
        for (let sel of obligatorios) {
            if (!$(sel).val()) {
                Swal.fire('Validación', 'Complete todos los campos obligatorios', 'warning');
                return false;
            }
        }
        return true;
    }

    $('#pokemonForm').on('submit', function (e) {
        e.preventDefault();
        if (!validarFormulario()) return;

        const id = $('#id').val();
        const action = id ? 'update' : 'create';
        const url = `pokemon?action=${action}` + (id ? `&id=${id}` : '');

        const data = {
            codigoRegistro: $('#codigoRegistro').val(),
            pokemonId: $('#pokemonId').val(),
            nombre: $('#nombre').val(),
            nombreJapones: $('#nombreJapones').val(),
            tipo1: $('#tipo1').val(),
            tipo2: $('#tipo2').val(),
            altura: $('#altura').val(),
            peso: $('#peso').val(),
            habilidad1: $('#habilidad1').val(),
            habilidad2: $('#habilidad2').val(),
            habilidadOculta: $('#habilidadOculta').val(),
            hp: $('#hp').val(),
            ataque: $('#ataque').val(),
            defensa: $('#defensa').val(),
            ataqueEspecial: $('#ataqueEspecial').val(),
            defensaEspecial: $('#defensaEspecial').val(),
            velocidad: $('#velocidad').val(),
            spriteUrl: $('#spriteUrl').val(),
            nombreEntrenador: $('#nombreEntrenador').val(),
            emailEntrenador: $('#emailEntrenador').val(),
            apodo: $('#apodo').val(),
            nivel: $('#nivel').val(),
            esCapturado: $('#esCapturado').val(),
            fechaCaptura: $('#fechaCaptura').val(),
            observaciones: $('#observaciones').val()
        };

        $.ajax({
            url: url,
            method: 'POST',
            data: data,
            success: function (res) {
                if (res.success) {
                    Swal.fire('Éxito', 'Registro guardado correctamente', 'success');
                    $('#pokemonForm')[0].reset();
                    $('#id').val('');
                    cargarTabla();
                } else {
                    Swal.fire('Error', res.message || 'No se pudo guardar', 'error');
                }
            },
            error: function () {
                Swal.fire('Error', 'Error en el servidor', 'error');
            }
        });
    });

    $('#tablaPokemon tbody').on('click', '.btn-editar', function () {
        const id = $(this).data('id');
        $.getJSON('pokemon', { action: 'getById', id: id }, function (res) {
            if (res.success && res.data) {
                const p = res.data;
                $('#id').val(p.id);
                $('#codigoRegistro').val(p.codigoRegistro);
                $('#pokemonId').val(p.pokemonId);
                $('#nombre').val(p.nombre);
                $('#nombreJapones').val(p.nombreJapones);
                $('#tipo1').val(p.tipo1);
                $('#tipo2').val(p.tipo2);
                $('#altura').val(p.altura);
                $('#peso').val(p.peso);
                $('#habilidad1').val(p.habilidad1);
                $('#habilidad2').val(p.habilidad2);
                $('#habilidadOculta').val(p.habilidadOculta);
                $('#hp').val(p.hp);
                $('#ataque').val(p.ataque);
                $('#defensa').val(p.defensa);
                $('#ataqueEspecial').val(p.ataqueEspecial);
                $('#defensaEspecial').val(p.defensaEspecial);
                $('#velocidad').val(p.velocidad);
                $('#spriteUrl').val(p.spriteUrl);
                $('#nombreEntrenador').val(p.nombreEntrenador);
                $('#emailEntrenador').val(p.emailEntrenador);
                $('#apodo').val(p.apodo);
                $('#nivel').val(p.nivel);
                $('#esCapturado').val(p.esCapturado ? 'true' : 'false');
                if (p.fechaCaptura) {
                    $('#fechaCaptura').val(p.fechaCaptura);
                }
                $('#observaciones').val(p.observaciones);
            }
        });
    });

    $('#tablaPokemon tbody').on('click', '.btn-eliminar', function () {
        const id = $(this).data('id');
        Swal.fire({
            title: '¿Eliminar registro?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then(result => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'pokemon?id=' + id,
                    method: 'DELETE',
                    success: function (res) {
                        if (res.success) {
                            Swal.fire('Eliminado', 'Registro eliminado', 'success');
                            cargarTabla();
                        } else {
                            Swal.fire('Error', 'No se pudo eliminar', 'error');
                        }
                    },
                    error: function () {
                        Swal.fire('Error', 'Error en el servidor', 'error');
                    }
                });
            }
        });
    });

    $('#btnBuscarPokemon').click(function () {
        const param = $('#searchPokemon').val();
        if (!param) {
            Swal.fire('Validación', 'Ingrese un nombre o ID de Pokémon', 'warning');
            return;
        }
        $.getJSON('pokemon', { action: 'getExternal', param: param }, function (res) {
            if (res.success && res.data) {
                const d = res.data;
                const tipos = (d.types || []).map(t => t.type.name).join(', ');
                const stats = (d.stats || []).map(s => `${s.stat.name}: ${s.base_stat}`).join(' | ');
                const sprite = d.sprites && d.sprites.front_default;

                $('#pokemonPreview').show();
                $('#previewNombre').text(d.name);
                $('#previewTipos').text(tipos);
                $('#previewStats').text(stats);
                if (sprite) $('#previewSprite').attr('src', sprite);

                $('#pokemonId').val(d.id);
                $('#nombre').val(d.name);
                $('#tipo1').val((d.types && d.types[0]) ? d.types[0].type.name : '');
                $('#tipo2').val((d.types && d.types[1]) ? d.types[1].type.name : '');
                $('#altura').val((d.height || 0) / 10);
                $('#peso').val((d.weight || 0) / 10);
                $('#spriteUrl').val(sprite || '');

                if (d.abilities && d.abilities.length > 0) {
                    $('#habilidad1').val(d.abilities[0].ability.name);
                    if (d.abilities[1]) $('#habilidad2').val(d.abilities[1].ability.name);
                    const oculta = d.abilities.find(a => a.is_hidden);
                    if (oculta) $('#habilidadOculta').val(oculta.ability.name);
                }

                if (d.stats && d.stats.length >= 6) {
                    $('#hp').val(d.stats[0].base_stat);
                    $('#ataque').val(d.stats[1].base_stat);
                    $('#defensa').val(d.stats[2].base_stat);
                    $('#ataqueEspecial').val(d.stats[3].base_stat);
                    $('#defensaEspecial').val(d.stats[4].base_stat);
                    $('#velocidad').val(d.stats[5].base_stat);
                }
            } else {
                Swal.fire('Error', res.message || 'No se encontraron datos en PokéAPI', 'error');
            }
        }).fail(function () {
            Swal.fire('Error', 'Error al conectar con PokéAPI', 'error');
        });
    });
});
