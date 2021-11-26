<%-- 
    Document   : peticionesVisitas
    Created on : 09-nov-2021, 22:28:55
    Author     : codes
--%>
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
        "listarTiposPersona",
        "listarTipoPersonaIndividual"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("listarTiposPersona")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<TipoPersona> lista = new TipoPersona().consultarTiposDePersona();
                
                respuesta += "\"" + proceso + "\": true,\"TiposDePersona\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"TiposDePersona\":[]";
                Logger.getLogger(tipoIngreso.class.getName()).log(Level.SEVERE, null, ex);
            }
//        
        }else if (proceso.equals("listarTipoPersonaIndividual")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            int idPersona = Integer.parseInt(request.getParameter("idPersona"));
            try {
                
                TipoPersona pfl = new TipoPersona(idPersona).consultarTipoPersonaIndividual();
                
                respuesta += "\"" + proceso + "\": true,\"TipoDePersona\":" + new Gson().toJson(pfl);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"TipoDePersona\":[]";
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