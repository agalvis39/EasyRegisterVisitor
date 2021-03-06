<%-- 
    Document   : apartamentos
    Created on : 16-nov-2021, 12:17:28
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
        <style>
            /*div{ border: dotted;}*/
        </style>
        <title>Apartamentos</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container-fluid" ng-app="apartamentos" ng-controller="consultarApartamentos as cap">
            <div class="form-row">
                <div class="col-9">
                    <div class="row">
                        <div class="col-4">
                            <label>Torre *</label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="Torre" ng-model="cap.torre">
                        </div>
                        <div class="col-3">
                            <label>Piso *</label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" ng-model="cap.piso" placeholder="Piso">
                        </div>
                        <div class="col-3">
                            <label>N??mero de Apartamento *</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">Acciones</button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="#" ng-click="cap.editar(cap.napartamento)">Buscar</a>
                                        <a class="dropdown-item" href="#" ng-click="cap.napartamento=null">Limpiar</a>
                                    </div>
                                </div>
                                <input type="number" class="form-control" placeholder="# Apartamento" ng-model="cap.napartamento">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-3">
                    <label>Propietario</label>
                    <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="Propietario" ng-model="cap.propietario">
                </div>
            </div>
            <div class="form-row">
                <div class="col-9">
                    <div class="form-row">
                        <div ng-init="cap.traerDireccion()" class="col-3">
                            <label>Direcci??n</label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="direcci??n" readonly="true" value="{{cap.direccion_1}}">
                        </div>
                        <div class="col-2">
                            <label><br></label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="torre" readonly="true" value="{{cap.torre}}">
                        </div>
                        <div class="col-1">
                            <label><br></label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="piso" readonly="true" value="{{cap.piso}}">
                        </div>
                        <div class="col-2">
                            <label><br></label>
                            <input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="Apartamento" readonly="true" value="{{cap.napartamento}}">
                        </div>
                        <!--                        <div class="col-2">
                        
                                                </div>-->
                    </div>
                    <div class="row">
                        <div class="col-3">
                            <label>Cit??fono</label>
                            <input type="number" class="form-control" aria-label="Text input with dropdown button" placeholder="Cit??fono" ng-model="cap.datafono">
                        </div>
                        <div class="col-2">
                            <br>
                            <button type="button" class="btn btn-success" ng-click="cap.guardar()">Guardar</button>
                        </div>
                        <div class="col-2">
                            <br>
                            <button type="button" class="btn btn-warning" ng-click="cap.actualizar(cap.nApto, cap.napartamento)">Actualizar</button>                        
                        </div>
                        <div class="col-2">
                            <br>
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#eliminarModal">Eliminar</button>
                        </div>
                        <div class="col-2">
                            <br>
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#limpiarModal">Limpiar</button>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <label><br></label>
                    <textarea class="form-control" placeholder="Residentes" rows="6" ng-model="cap.residentes"></textarea>
                    <br>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark" ng-init="cap.listarAptos()">
                            <tr>
                                <th scope="col"># Apto</th>
                                <th scope="col">Torre</th>
                                <th scope="col">Piso</th>
                                <th scope="col">Propietario</th>
                                <th scope="col">Residentes</th>
                                <th scope="col">Direcci??n</th>
                                <th scope="col">Cit??fono</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="ap in cap.Apartamentos">
                                <td>{{ap.nApartamento}}</td>
                                <td>{{ap.torre}}</td>
                                <td>{{ap.piso}}</td>
                                <td>{{ap.propietario}}</td>
                                <td>
                                    <textarea class="form-control" rows="6" disabled="">{{ap.residente}}</textarea>
                                </td>
                                <td>{{ap.direccion}}</td>
                                <td>{{ap.datafono}}</td>
                                <td>
                                    <div class="row">
                                        <div class="col6 mr-3">
                                            <button type="button" class="btn btn-info" ng-click="cap.editar(ap.nApartamento)">Editar</button>
                                        </div>
                                        <!--                                        <div class="col6">
                                                                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#verMasModal" >Ver mas</button>
                                                                                </div>-->
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarModalLabel">??Seguro desea eliminar este Apartamento?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            El registro ser?? eliminado completamente de la base de datos
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="cap.eliminar()">SI</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="limpiarModal" tabindex="-1" aria-labelledby="limpiarLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="limpiarModalLabel">??Seguro desea limpiar todos los campos?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Toda el formulario ser?? limpiado
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="cap.limpiarCampos()">SI</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var app = angular.module('apartamentos', []);
        app.controller('consultarApartamentos', ['$http', controladorApartamentos]);
        function controladorApartamentos($http) {
            var cap = this;
            validar = function (tipoDeValidacion) {
//                var apartamento = cap.nApto ? true : false;
                var torre = cap.torre ? true : false;
                var piso = cap.piso ? true : false;
                var propietario = cap.propietario ? true : false;
                var residentes = cap.residentes ? true : false;
                var napartamento = cap.napartamento ? true : false;
//                var datafono = cap.datafono ? true : false;
                if (tipoDeValidacion === 'Actualizar') {
                    if (torre && piso && propietario && residentes
                        && napartamento) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            };
            cap.listarAptos = function () {
                var parametros = {
                    proceso: 'listarApartamento'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesApartamento.jsp',
                    params: parametros
                }).then(function (res) {
                    cap.Apartamentos = res.data.Apartamentos;
                });
            };
            cap.traerDireccion = function () {
                var parametros = {
                    proceso: 'listarDirecciones'
                };
                $http({
                    method: 'POST',
                    url: 'peticionesDireccion.jsp',
                    params: parametros
                }).then(function (res) {
                    cap.direccion_1 = res.data.Direcciones.direccion;
                });
            };
            cap.editar = function (nApto) {
                var parametros = {
                    proceso: 'consultarIndividualApartamento',
                    nApartamento: nApto
                };
                $http({
                    method: 'POST',
                    url: 'peticionesApartamento.jsp',
                    params: parametros
                }).then(function (res) {
//                    alert(JSON.stringify(res.data.Apartamento));
                    cap.nApto = res.data.Apartamento.nApartamento;
                    cap.torre = res.data.Apartamento.torre;
                    cap.piso = res.data.Apartamento.piso;
                    cap.propietario = res.data.Apartamento.propietario;
                    cap.residentes = res.data.Apartamento.residente;
                    cap.napartamento = res.data.Apartamento.nApartamento;
                    cap.datafono = res.data.Apartamento.datafono;
                });
            };
            cap.actualizar = function (nApto, nuevoApto) {
                if (validar('Actualizar')) {
                    alert(nApto);
                    alert(nuevoApto);
                    var parametros = {

                        proceso: 'actualizarApartamento',
                        nApartamento: nuevoApto,
                        Apto: nApto,        
                        residente: cap.residentes,
                        propietario: cap.propietario,
                        torre: cap.torre,
                        piso: cap.piso,
                        direccion: cap.direccion_1 + " torre " + cap.torre + " piso " + cap.piso + " #Apto " + cap.napartamento,
                        datafono: cap.datafono
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesApartamento.jsp',
                        params: parametros
                    }).then(function (res) {
    //                    alert(cap.nApto);
                        if (res.data.ok === true) {
                            if (res.data.actualizarApartamento === true) {
                                swal({
                                    title: "Ejecut??",
                                    text: "El registro fue actualizado exitosamente",
                                    icon: "success",
                                    button: "cerrar"
                                });
                                cap.listarAptos();
                            } else {
                                swal({
                                    title: "No ejecut??",
                                    text: "El registro no fue actualizado exitosamente",
                                    icon: "error",
                                    button: "cerrar"
                                });
                            }
                        }
                    });
                }else {
                        swal({
                            title: "Verificar Campos",
                            text: "Todos los campos son obligatorios, excepto 'Cit??fono'",
                            icon: "warning",
                            button: "cerrar"
                        });
                }
            };
            cap.guardar = function () {
                if (validar('Actualizar')) {
                    var parametros = {
                        proceso: 'guardarApartamento',
                        nApartamento: cap.napartamento,
                        residente: cap.residentes,
                        propietario: cap.propietario,
                        torre: cap.torre,
                        piso: cap.piso,
                        direccion: cap.direccion_1 + " torre " + cap.torre + " piso " + cap.piso + " #Apto " + cap.napartamento,
                        datafono: cap.datafono
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesApartamento.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardarApartamento === true) {
                                swal({
                                    title: "Guard??",
                                    text: "El registro fue guardado exitosamente",
                                    icon: "success",
                                    button: "cerrar"
                                });
                                cap.listarAptos();
                            } else {
                                swal({
                                    title: "No guard??",
                                    text: "El registro no fue guardado exitosamente",
                                    icon: "error",
                                    button: "cerrar"
                                });

                            }
                        } else {
                            swal({
                                title: "Fall??",
                                text: res.data.errorMsg,
                                icon: "error",
                                button: "cerrar"
                            });
                        }
                    });
                }else {
                        swal({
                            title: "Verificar Campos",
                            text: "Todos los campos son obligatorios, excepto 'Cit??fono'",
                            icon: "warning",
                            button: "cerrar"
                        });
                }
            };
            cap.eliminar = function () {
                var parametros = {
                    proceso: 'eliminarApartamento',
                    nApartamento: cap.napartamento
                };
                $http({
                    method: 'POST',
                    url: 'peticionesApartamento.jsp',
                    params: parametros
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data.eliminarApartamento === true) {
                            swal({
                                title: "Ejecut??",
                                text: "El registro fue eliminado exitosamente",
                                icon: "success",
                                button: "cerrar"
                            });
                            cap.listarAptos();
                        } else {
                            swal({
                                title: "No ejecut??",
                                text: "El registro no fue eliminado exitosamente",
                                icon: "error",
                                button: "cerrar"
                            });
                        }
                    } else {
                        swal({
                            title: "Fall??",
                            text: res.data.errorMsg,
                            icon: "error",
                            button: "cerrar"
                        });
                    }
                });
            };
            cap.limpiarCampos = function(){
                cap.nApto = null;
                cap.torre = null;
                cap.piso = null;
                cap.propietario = null;
                cap.residentes = null;
                cap.napartamento = null;
                cap.datafono = null;
            };
        };
        
    </script>
</html>
