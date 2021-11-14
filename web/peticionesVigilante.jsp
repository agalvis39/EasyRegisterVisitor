<%-- 
    Document   : peticionesVigilante
    Created on : 13-nov-2021, 20:54:04
    Author     : codes
--%>

<%@page import="logica.Vigilante"%>
<%@page import="logica.Visitas"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>


<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "guardarVigilante",
        "eliminarRegistroVigilante",
        "actualizarRegistroVigilante",
        "listarVigilantes",
        "consultarUnVigilante"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validaci�n de par�metros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarVigilante")) {
//            Solicitud de par�metros enviados desde el frontned
//            , uso de request.getParameter("nombre parametro")
//             creaci�n de objeto y llamado a m�todo guardar
//            
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");
            Vigilante vig = new Vigilante(identificacion, nombre, usuario, contrasenia);
            
//            
            
            if (vig.guardarVigilante()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarRegistroVigilante")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado a m�todo eliminar
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            Vigilante vig = new Vigilante();
            vig.setIdentificacion(identificacion);
            if (vig.eliminarVigilante()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarVigilantes")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado al metodo listar
            try {
                List<Vigilante> lista = new Vigilante().consultarVigilantes();
                respuesta += "\"" + proceso + "\": true,\"Vigilantes\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Vigilantes\":[]";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarUnVigilante")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado al metodo consultarIndividual
            int identificacion= Integer.parseInt(request.getParameter("identificacion"));
            
            try {
                Vigilante obj =new Vigilante();
                obj.setIdentificacion(identificacion);
                obj.buscarVigilante();
                respuesta += "\"" + proceso + "\": true,\"Vigilante\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\" Vigilante\":null";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarRegistroVigilante")) {
            //creaci�n de objeto y llamado al metodo actualizar
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");
            Vigilante vig = new Vigilante(identificacion, nombre, usuario, contrasenia);
            
            if (vig.actualizarVigilante()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inv�lidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Responder como objeto JSON codificaci�n ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>