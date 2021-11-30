<%-- 
    Document   : consultaVisitas
    Created on : 16-nov-2021, 12:33:45
    Author     : codes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--        <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
        <script src="js/bootstrap-datetimepicker.min.js"></script>-->
        <style>
            /*div{ border: dotted;}*/
        </style>
        <title>Minutas</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container-fluid" ng-app="minutas_1" ng-controller="consultarMinutas as cm">
            <div class="form-row">
                <div class="col-2">
                    <label>Ingreso</label>
                    <input type="datetime-local" class="form-control" ng-model="cm.ingreso">
                </div>
                <div class="col-2">
                    <label>Salida</label>
                    <input type="datetime-local" class="form-control" ng-model="cm.salida">
                </div>
            </div>
            <br>    
            <div class="form-row">
                <div class="w-75 col-3">
                    <label>Identificación</label>
                    <input type="text" class="w-75 form-control" aria-label="Text input with dropdown button" placeholder="Identificación" ng-model="cm.identificacion">
                    <br>
                    <label>Nombre</label>
                    <input type="text" class="w-75 form-control" aria-label="Text input with dropdown button" placeholder="Nombre" ng-model="cm.nombre">
                    <div class="form-row">
                        <div class="col-3">
                            <div>
                                <br>
                                <button type="button" class="btn btn-success" ng-click="cm.guardar()">Guardar</button>
                            </div>
                        </div>
                        <div class="col-3">
                            <div>
                                <br>
                                <button type="button" class="btn btn-warning" ng-click="cm.actualizar(cm.nminuta)">Actualizar</button>                        
                            </div>
                        </div>
                        <div class="col-3">
                            <div>
                                <br>
                                <button type="button" class="btn btn-info" ng-click="cm.limpiarForm()">Limpiar</button>                        
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                   

                    <label>Perfil</label>
                    <select class="w-75 form-control" ng-model="cm.tipopersona" ng-init="cm.listarTiposPersona()">
                        <option ng-repeat="p in cm.Perfiles" value="{{p.idPersona}}">{{p.persona}}</option>
                    </select>
                    <br>
                    <label>Destino</label>
                    <select class="w-50 form-control" ng-model="cm.Destino_select" ng-init="cm.listarApartamentos()">
                        <option ng-repeat="a in cm.Apartamentos" value="{{a.nApartamento}}">{{a.nApartamento}}</option>
                    </select>
                    
                    <br>
                    
                    <br>
                
                   
                </div>
                <div class="col-3">
                    
                    <label>Tipo de Ingreso</label>
                    <select onchange="carg(this, null)" class="w-50 form-control" ng-model="cm.tipoingreso" ng-init="cm.listarTipoIngreso()" name="id_TipoIngreso" id="id_TipoIngreso">
                        <option ng-repeat="c in cm.listaTipoIngreso" value="{{c.idTipoIngreso}}">{{c.tipoIngreso_1}}</option>
                    </select>
                    <br>
                    
                    <div class="form-row">
                        <div class="col-6"><label>Indique matrícula del vehículo si aplica: </label>
                            <input id="input" type="text" class="form-control" placeholder="Matrícula" disabled="" ng-model="cm.tarjetavehiculo"></div>
                    </div>
                    <br>
                    <label>Autorización</label>
                    <select class="w-50 form-control" ng-model="cm.autorizacion" ng-init="cm.listarAutorizacion()">
                        <option ng-repeat="at in cm.ListaAutorizacion" value="{{at.idAutorizacion}}">{{at.Autorizacion}}</option>
                    </select>

                </div>
                <div class="col-3">

                    <br>
                    <textarea class="form-control" placeholder="Observaciones" rows="6" ng-model="cm.observacion"></textarea>
                    <br>
                </div>
                
            </div>
            <br>
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark" ng-init="cm.listarMinutas()">
                            <tr>
                                <th scope="col">id</th>
                                <th scope="col">Identificacion</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Destino</th>
                                <th scope="col">Perfil</th>
                                <th scope="col">Tipo de Ingreso</th>
                                <th scope="col">Matrícula</th>
                                <th scope="col">Autorización</th>
                                <th scope="col">Ingreso</th>
                                <th scope="col">Salida</th>
                                <th scope="col">observacion</th>
                                <th scope="col">Acciones</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="ap in cm.minutas">
                                <td>{{ap.idVisita}}</td>
                                <td>{{ap.identificacion}}</td>
                                <td>{{ap.nombre}}</td>
                                <td>{{ap.destino}}</td>
                                <td>{{ap.perfil.persona}}</td>
                                <td>{{ap.tipoIngreso.tipoIngreso_1}}</td>
                                <td>{{ap.tarjetaVehiculo}}</td>
                                <td>{{ap.autorizacion.Autorizacion}}</td>
                                <td>{{ap.ingreso}}</td>
                                <td>{{ap.salida}}</td>
                                <td>
                                    <textarea class="form-control" rows="6" disabled="">{{ap.observacion}}</textarea>
                                </td>
                                
                                <td>
                                    <div class="row">
                                        <div class="col6 mr-3">
                                            <button type="button" class="btn btn-info" ng-click="cm.editar(ap.idVisita)">Editar</button>
                                        </div>
                                       
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
<!--            <div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarModalLabel">¿Seguro desea eliminar esta Visita?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            El registro será eliminado completamente de la base de datos
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="cap.eliminar()">SI</button>
                        </div>
                    </div>
                </div>
            </div>-->
        </div>
    </body>
    <script>
        var input = document.getElementById('input');

        function carg(elemento, elemento2) {
            if (elemento2 === null){
                d = elemento.value;
                if(d === "1"){
                    input.disabled = true;
                }else{
                    input.disabled = false;
                }
            }else{
                e = elemento2;
                if(e === "1"){
                    input.disabled = true;
                }else{
                    input.disabled = false;
                }  
            }
        }
    </script>
    <script>
        var app = angular.module('minutas_1', []);
        app.controller('consultarMinutas', ['$http', controladorMinutas]);
        function controladorMinutas($http) {
            var cm = this;
            validar = function (tipoDeValidacion) {
                var identificacion = cm.identificacion ? true : false;
                var nombre = cm.nombre ? true : false;
                var destino = cm.Destino_select ? true : false;
                var tipo_ingreso = cm.tipoingreso ? true : false;
                var matricula = cm.tarjetavehiculo ? true : false;
                var autorizacionVar = cm.autorizacion ? true : false;
                var ingreso = cm.ingreso ? true : false;
                var salida = cm.salida ? true : false;
                var observacionVar = cm.observacion ? true : false;
                var tipo_persona = cm.tipopersona ? true : false;
                
                
                if (tipoDeValidacion === 'MetodoActualizar') {
                    if (identificacion && nombre && destino &&
                        tipo_ingreso && matricula && 
                        autorizacionVar && ingreso && salida &&
                        observacionVar && tipo_persona) {
                        return true;
                    } else {
                        return false;
                    }
                } else if (tipoDeValidacion === 'MetodoGuardar') {
                    if (identificacion && nombre && destino &&
                        tipo_ingreso && 
                        autorizacionVar && ingreso &&
                        tipo_persona) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            };
            cm.listarMinutas = function () {
                var parametros = {
                    proceso: 'listarVisitas'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesVisitas.jsp',
                    params: parametros
                }).then(function (res) {
                    cm.minutas = res.data.Visitas;
                });
            };
            cm.listarTipoIngreso = function () {
                var parametros = {
                    proceso: 'listarTipoIngreso'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesTipoIngreso.jsp',
                    params: parametros
                }).then(function (res) {
                    cm.listaTipoIngreso = res.data.TiposDeIngreso;
                });
            };
            cm.listarTiposPersona = function () {
                var parametros = {
                    proceso: 'listarTiposPersona'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesTipoPersona.jsp',
                    params: parametros
                }).then(function (res) {
                    
                    cm.Perfiles = res.data.TiposDePersona;
                });
            };
            cm.listarApartamentos = function () {
                var parametros = {
                    proceso: 'listarApartamento'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesApartamento.jsp',
                    params: parametros
                }).then(function (res) {
                    
                    cm.Apartamentos = res.data.Apartamentos;
                });
            };
            cm.listarAutorizacion = function () {
                var parametros = {
                    proceso: 'listarAutorizacion'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesAutorizacion.jsp',
                    params: parametros
                }).then(function (res) {
                    
                    cm.ListaAutorizacion = res.data.ListaAutorizacion;
                });
            };
            cm.editar = function (nMinuta) {
                var parametros = {
                    proceso: 'consultarUnaVisita',
                    idVisita: nMinuta
                };
                $http({
                    method: 'POST',
                    url: 'peticionesVisitas.jsp',
                    params: parametros
                }).then(function (res) {
                    cm.nminuta = res.data.Visita.idVisita;
                    cm.identificacion = res.data.Visita.identificacion;
                    cm.nombre = res.data.Visita.nombre;
                    cm.Destino_select = res.data.Visita.destino.toString();
                    cm.tipoingreso = res.data.Visita.idTipoIngreso.toString();
                    cm.tarjetavehiculo = res.data.Visita.tarjetaVehiculo;
                    cm.autorizacion = res.data.Visita.idAutorizacion.toString();
                    cm.ingreso = res.data.Visita.ingreso;
                    cm.salida = res.data.Visita.salida;
                    cm.observacion = res.data.Visita.observacion;
                    cm.tipopersona = res.data.Visita.tipoPersona.toString();
                    
                    carg(null, cm.tipoingreso);
                    
                    
                });
            };
            cm.limpiarForm = function(){
                cm.nminuta = null;
                cm.identificacion = null;
                cm.nombre = null;
                cm.Destino_select = null;
                cm.tipoingreso = null;
                cm.tarjetavehiculo = null;
                cm.autorizacion = null;
                cm.ingreso = null;
                cm.salida = null;
                cm.observacion = null;
                cm.tipopersona = null;
            };
            
            cm.actualizar = function (nMinuta) {
                if (validar('MetodoActualizar')) {
                    var parametros = {

                        proceso: 'actualizarMinutas',
                        idVisita: cm.nminuta,
                        identificacion: cm.identificacion,
                        nombre: cm.nombre,
                        destino: cm.Destino_select,
                        tarjetaVehiculo: cm.tarjetavehiculo,
                        autorizacion: cm.autorizacion,
                        idTipoIngreso: cm.tipoingreso,
                        ingreso: cm.ingreso,
                        salida: cm.salida,
                        observacion: cm.observacion,
                        tipoPersona: cm.tipopersona
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesVisitas.jsp',
                        params: parametros
                    }).then(function (res) {
                        alert(nMinuta);
                        if (res.data.ok === true) {
                            if (res.data.actualizarMinuta === true) {
                                swal({
                                    title: "Ejecutó",
                                    text: "El registro fue actualizado exitosamente",
                                    icon: "success",
                                    button: "cerrar"
                                });
                                cap.listarMinutas();
                            } else {
                                swal({
                                    title: "No ejecutó",
                                    text: "El registro no fue actualizado exitosamente",
                                    icon: "error",
                                    button: "cerrar"
                                });
                            }
                        }
                    });
                    
                } else {
                        swal({
                            title: "Verificar Campos",
                            text: "todos los campos son obligatorios",
                            icon: "warning",
                            button: "cerrar"
                        });
                }
            };
            cm.guardar = function () {
                if (validar('MetodoGuardar')) {
                    var parametros = {
                        proceso: 'guardarVisita',

                        identificacion: cm.identificacion,
                        nombre: cm.nombre,
                        destino: cm.Destino_select,
                        tarjetaVehiculo: cm.tarjetavehiculo,
                        autorizacion: cm.autorizacion,
                        idTipoIngreso: cm.tipoingreso,
                        ingreso: cm.ingreso,
                        salida: cm.salida,
                        observacion: cm.observacion,
                        tipoPersona: cm.tipopersona

                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesVisitas.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardarVisita === true) {
                                swal({
                                    title: "Guardó",
                                    text: "El registro fue guardado exitosamente",
                                    icon: "success",
                                    button: "cerrar"
                                });
                                cm.listarMinutas()();
                            } else {
                                swal({
                                    title: "No guardó",
                                    text: "El registro no fue guardado exitosamente",
                                    icon: "error",
                                    button: "cerrar"
                                });

                            }
                        } else {
                            swal({
                                title: "Falló",
                                text: res.data.errorMsg,
                                icon: "error",
                                button: "cerrar"
                            });
                        }
                    });
                } else {
                        swal({
                            title: "Verificar Campos",
                            text: "Identificación, Nombre, Destino, Autorización, Perfil, Ingreso, Tipo de Ingreso\nObligatorios",
                            icon: "warning",
                            button: "cerrar"
                        });
                }
            };
//            
        };
    </script>
</html>