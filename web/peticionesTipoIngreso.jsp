<%-- 
    Document   : peticionesVisitas
    Created on : 09-nov-2021, 22:28:55
    Author     : codes
--%>
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
        "listarTipoIngreso"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validaci?n de par?metros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("listarTipoIngreso")) {
            //Solicitud de par?metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci?n de objeto y llamado al metodo listar
            try {
                List<tipoIngreso> lista = new tipoIngreso().consultarTiposDeIngreso();
                
                respuesta += "\"" + proceso + "\": true,\"TiposDeIngreso\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"TiposDeIngreso\":[]";
                Logger.getLogger(tipoIngreso.class.getName()).log(Level.SEVERE, null, ex);
            }
//        
        }else if (proceso.equals("listarTipoIngresoIndividual")) {
            //Solicitud de par?metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci?n de objeto y llamado al metodo listar
            int idTipoIngreso = Integer.parseInt(request.getParameter("idTipoIngreso"));
            try {
                tipoIngreso TIP = new tipoIngreso(idTipoIngreso).consultarTipoIngresoIndividual();
                
                respuesta += "\"" + proceso + "\": true,\"TipoDeIngreso\":" + new Gson().toJson(TIP);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"TipoDeIngreso\":[]";
                Logger.getLogger(tipoIngreso.class.getName()).log(Level.SEVERE, null, ex);
            }
//        
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inv?lidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Responder como objeto JSON codificaci?n ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>