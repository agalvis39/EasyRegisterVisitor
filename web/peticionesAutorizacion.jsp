<%-- 
    Document   : peticionesVisitas
    Created on : 09-nov-2021, 22:28:55
    Author     : codes
--%>
<%@page import="logica.Autorizacion"%>
<%@page import="logica.TipoPersona"%>
<%@page import="logica.tipoIngreso"%>
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
        "listarAutorizacion",
        "listarAutorizacionIndividual"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("listarAutorizacion")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<Autorizacion> lista = new Autorizacion().consultarAutorizacion();
                
                respuesta += "\"" + proceso + "\": true,\"ListaAutorizacion\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"ListaAutorizacion\":[]";
                Logger.getLogger(tipoIngreso.class.getName()).log(Level.SEVERE, null, ex);
            }
//        
        }else if (proceso.equals("listarAutorizacionIndividual")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            int idAutorizacion = Integer.parseInt(request.getParameter("idAutorizacion"));
            try {
                
                Autorizacion aut = new Autorizacion(idAutorizacion).consultarAutorizacionIndividual();
                
                respuesta += "\"" + proceso + "\": true,\"Autorizacion\":" + new Gson().toJson(aut);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Autorizacion\":[]";
                Logger.getLogger(tipoIngreso.class.getName()).log(Level.SEVERE, null, ex);
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