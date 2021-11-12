<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logica.Apartamentos"%>
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
        "guardarApartamento",
        "eliminarApartamento",
        "actualizarApartamento",
        "listarApartamento",
        "consultarIndividualApartamento"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarApartamento")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar 
            int nApartamento = Integer.parseInt(request.getParameter("nApartamento"));
            String propietario = request.getParameter("propietario");
            String residente = request.getParameter("residente");
            String torre = request.getParameter("torre");
            String direccion = request.getParameter("direccion");
            int datafono = Integer.parseInt(request.getParameter("datafono"));
            String piso = request.getParameter("piso");

            Apartamentos apart = new Apartamentos(); //crear objeto asiganar valores

            apart.setnApartamento(nApartamento);
            apart.setPropetario(propietario);
            apart.setResidente(residente);
            apart.setTorre(torre);
            apart.setDireccion(direccion);
            apart.setDatafono(datafono);
            apart.setPiso(piso);
            if (apart.guardarApartamento()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarApartamento")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int nApartamento = Integer.parseInt(request.getParameter("nApartamento"));
            Apartamentos apart = new Apartamentos(nApartamento);
            
            if (apart.eliminarApartamento()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarApartamento")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<Apartamentos> lista = new Apartamentos().consultaTodosApartamentos();
                respuesta += "\"" + proceso + "\": true,\"Apartamentos\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Apartamentos\":[]";
                Logger.getLogger(Apartamentos.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("consultarIndividualApartamento")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            int nApartamento = Integer.parseInt(request.getParameter("nApartamento"));

            try {
                Apartamentos obj = new Apartamentos(nApartamento).consultaIndividualApartamento();
                respuesta += "\"" + proceso + "\": true,\"Apartamento\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Apartamento \":null";
                Logger.getLogger(Apartamentos.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarApartamento")) {
            //creación de objeto y llamado al metodo actualizar
            int nApartamento = Integer.parseInt(request.getParameter("nApartamento"));
            String propietario = request.getParameter("propietario");
            String residente = request.getParameter("residente");
            String torre = request.getParameter("torre");
            String direccion = request.getParameter("direccion");
            int datafono = Integer.parseInt(request.getParameter("datafono"));
            String piso = request.getParameter("piso");

            Apartamentos apart = new Apartamentos(); //crear objeto asiganar valores

            apart.setnApartamento(nApartamento);
            apart.setPropetario(propietario);
            apart.setResidente(residente);
            apart.setTorre(torre);
            apart.setDireccion(direccion);
            apart.setDatafono(datafono);
            apart.setPiso(piso);
            if (apart.actualizarApartamento()) {
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
