<%-- 
    Document   : login
    Created on : 30-nov-2021, 19:10:11
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
        <title>Home</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container-fluid" ng-app="login" ng-controller="loginController as lc">
            <div class="row">
                <div class="col-3"></div>
                <div class="col-3">
                    Registro de Usuario
                    <br>
                    <div class="row">
                        <div class="col-12">
                            <br>
                            <label>Identificación</label>
                            <input type="text" class="form-control" ng-model="lc.identificacion_reg">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <label>Nombre</label>
                            <input type="text" class="form-control" ng-model="lc.nombre_reg">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <label>Nombre usuario</label>
                            <input type="text" class="form-control" ng-model="lc.nombreDeUsuario_reg">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <label>Contraseña</label>
                            <input type="password" class="form-control" ng-model="lc.contrasenna_reg">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
<!--                            <label>Contraseña</label>
                            <input type="password" class="form-control" ng-model="lc.contrasenna">-->
                            <label>Perfil</label>
                            <select class="w-75 form-control" ng-model="lc.tipoUsuario_reg">
                                <option  value="1">Vigilante</option>
                                <option  value="2">Administrador de Conjunto</option>
                            </select>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="button" class="btn btn-primary mt-2" ng-click="lc.guardarPerfil(lc.tipoUsuario_reg)">Registrarse</button>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    Inicio de Sesión
                    <div class="row">
                        <div class="col-12">
                            <br>
                            <label>Nombre usuario</label>
                            <input type="text" class="form-control" ng-model="lc.nombreDeUsuario_int">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <label>Contraseña</label>
                            <input type="password" class="form-control" ng-model="lc.contrasenna_int">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <label>Perfil</label>
                            <select class="w-75 form-control" ng-model="lc.tipoUsuario_int" >
                                <option  value="1">Vigilante</option>
                                <option  value="2">Administrador de Conjunto</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="button" class="btn btn-primary mt-2" ng-click="lc.iniciarSesion(lc.tipoUsuario_int)">Iniciar sesion</button>
                        </div>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
        </div>
        <script>
            var app = angular.module('login', []);
            app.controller('loginController', ['$http', controladorLogin]);
            function controladorLogin($http) {
                var lc = this;
                lc.guardarPerfil = function (perfil) {
                    var parametros = {
                        proceso: (perfil===1)? 'guardarVigilante':'guardarAdminConjunto',
                        identificacion: lc.identificacion_reg,
                        nombre: lc.nombre_reg,
                        usuario: lc.nombreDeUsuario_reg,
                        contrasena: lc.contrasenna_reg
                    };
                    $http({
                        
                        method: 'POST',
                        params: parametros,
                        url: (perfil===1)? 'peticionesVigilante.jsp':'peticionesAdminConjunto.jsp'
                        
                    }).then(function (res) {
                        if (res.data.ok === true) {
//                            if (res.data.iniciarSesion === true) {
//                                window.location.href = "autores.jsp";
//                            } else {
//                                alert('No puede iniciar sesion');
//                            }
                            alert('puede iniciar sesion');
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
                lc.iniciarSesion = function (perfil) {
                    (perfil==="1")? alert(perfil):(perfil==="2")? alert(perfil): alert("No ha escogido un perfil");
                    var parametros = {
                        proceso: (perfil==="1")? 'consultarUnVigilante': (perfil==="2")? 'consultarUnAdminConjunto':"null",
                        usuario: lc.nombreDeUsuario_int,
                        contrasena: lc.contrasenna_int
                        
                    };
                    $http({
                        
                        method: 'POST',
                        params: parametros,
                        url: (perfil==="1")? 'peticionesVigilante.jsp': (perfil==="2")? 'peticionesAdminConjunto.jsp':" "
                        
                    }).then(function (res) {
                        alert(lc.nombreDeUsuario_int);
                        alert(lc.contrasenna_int);
                        if (res.data.ok === true) {
                            if (res.data.consultarUnVigilante === true  || res.data.consultarUnAdminConjunto === true) {
                                window.location.href = "minutas_1.jsp";
                            } else {
                                alert('No puede iniciar sesion');
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
            }

        </script>
    </body>
</html>
