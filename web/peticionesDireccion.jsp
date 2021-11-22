<%-- 
    Document   : peticionesVisitas
    Created on : 09-nov-2021, 22:28:55
    Author     : codes
--%>
<%@page import="logica.Direccion"%>
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
        "guardarDireccion",
        "actualizarDireccion",
        "listarDirecciones",
        "consultarDireccion"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarDireccion")) {
//            Solicitud de parámetros enviados desde el frontned
//            , uso de request.getParameter("nombre parametro")
//             creación de objeto y llamado a método guardar
            
            String direccion = request.getParameter("direccion");
            
            Direccion dir = new Direccion();
            
            dir.setDireccion(direccion);
            
            
            if (dir.guardarDireccion()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarDirecciones")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                Direccion lista = new Direccion().consultarDirecciones();
                respuesta += "\"" + proceso + "\": true,\"Direcciones\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Direcciones\":[]";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarDireccion")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            int idDireccion= Integer.parseInt(request.getParameter("idDireccion"));
            try {
                Direccion obj =new Direccion(idDireccion).consultaIndividualDireccion();
                respuesta += "\"" + proceso + "\": true,\"Direccion\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Direccion\":null";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarDireccion")) {
            //creación de objeto y llamado al metodo actualizar
            int idDireccion = Integer.parseInt(request.getParameter("idDireccion"));
            
            String direccion = request.getParameter("direccion");
            
            Direccion dir = new Direccion(idDireccion);
            dir.setIdDireccion(idDireccion);
            dir.setDireccion(direccion);
            
            if (dir.actualizarDireccion()) {
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
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>