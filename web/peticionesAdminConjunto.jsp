<%-- 
    Document   : peticionesAdminConjunto
    Created on : 22/11/2021, 02:28:23 PM
    Author     : Diego
--%>

<%@page import="logica.AdminConjunto"%>
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
        "guardarAdminConjunto",
        "eliminarAdminConjunto",
        "actualizarAdminConjunto",
        "listarAdminConjunto",
        "consultarUnAdminConjunto"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validaci�n de par�metros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarAdminConjunto")) {
//            Solicitud de par�metros enviados desde el frontned
//            , uso de request.getParameter("nombre parametro")
//             creaci�n de objeto y llamado a m�todo guardar
//            
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            AdminConjunto Adm = new AdminConjunto(identificacion, nombre, usuario, contrasena);
            
//            
            
            if (Adm.guardarAdminConjunto()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarAdminConjunto")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado a m�todo eliminar
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            AdminConjunto Adm = new AdminConjunto();
            Adm.setIdentificacion(identificacion);
            if (Adm.eliminarAdminConjunto()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarAdminConjunto")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado al metodo listar
            try {
                List<AdminConjunto> lista = new AdminConjunto().consultarTodasLosAdminConjunto();
                respuesta += "\"" + proceso + "\": true,\"AdminConjuntos\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"AdminConjuntos\":[]";
                Logger.getLogger(AdminConjunto.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarUnAdminConjunto")) {
            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado al metodo consultarIndividual
            int identificacion= Integer.parseInt(request.getParameter("identificacion"));
            String contrasena = request.getParameter("contrase�a");
            AdminConjunto AC = new AdminConjunto();
            AC.setIdentificacion(identificacion);
            AC.setContrasena(contrasena);
            AC.consultarAdminConjunto();
            if (AC != null) {
                session.setAttribute("usuario", AC);
                respuesta += "\"" + proceso + "\": true";
            } else {
                session.invalidate();
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("cerrarSesion")) {
            session.invalidate();
            respuesta += "\"" + proceso + "\": true";
        }
        } else if (proceso.equals("actualizarAdminConjunto")) {
            //creaci�n de objeto y llamado al metodo actualizar
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            AdminConjunto Adm = new AdminConjunto(identificacion, nombre, usuario, contrasena);
            
            if (Adm.actualizarAdminConjunto()) {
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