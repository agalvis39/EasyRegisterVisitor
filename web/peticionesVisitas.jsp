<%-- 
    Document   : peticionesVisitas
    Created on : 09-nov-2021, 22:28:55
    Author     : codes
--%>
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
        "guardarVisita",
        "eliminarRegistroVisita",
        "actualizarRegistroVisita",
        "listarVisitas",
        "consultarUnaVisita"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarVisita")) {
//            Solicitud de parámetros enviados desde el frontned
//            , uso de request.getParameter("nombre parametro")
//             creación de objeto y llamado a método guardar
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            int destino = Integer.parseInt(request.getParameter("destino"));
            int idTipoIngreso = Integer.parseInt(request.getParameter("idTipoIngreso"));
            String tarjetaVehiculo = request.getParameter("tarjetaVehiculo");
            int autorizacion = Integer.parseInt(request.getParameter("autorizacion"));
            String ingreso = request.getParameter("ingreso");
            String salida =  request.getParameter("salida");
            String observacion = request.getParameter("observacion");
            int tipoPersona = Integer.parseInt(request.getParameter("tipoPersona"));
            Visitas vis = new Visitas();
            
            vis.setIdentificacion(identificacion);
            vis.setNombre(nombre);
            vis.setDestino(destino);
            vis.setIdTipoIngreso(idTipoIngreso);
            vis.setTarjetaVehiculo(tarjetaVehiculo);
            vis.setIdAutorizacion(autorizacion);
            vis.setIngreso(ingreso);
            vis.setSalida(salida);
            vis.setObservacion(observacion);
            vis.setTipoPersona(tipoPersona);
            
            if (vis.guardarVisita()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarRegistroVisita")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int idVisita = Integer.parseInt(request.getParameter("idVisita"));
            Visitas vis = new Visitas(idVisita);
            
            if (vis.eliminarVisita()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarVisitas")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<Visitas> lista = new Visitas().consultarTodasLasVisitas();
                
                respuesta += "\"" + proceso + "\": true,\"Visitas\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Visitas\":[]";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarUnaVisita")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            int idVisitas= Integer.parseInt(request.getParameter("idVisita"));
            try {
                Visitas obj =new Visitas(idVisitas).consultarVisita();
                respuesta += "\"" + proceso + "\": true,\"Visita\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\" Visita\":null";
                Logger.getLogger(Visitas.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarRegistrovisita")) {
            //creación de objeto y llamado al metodo actualizar
            int idVisita = Integer.parseInt(request.getParameter("idVisita"));
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            int destino = Integer.parseInt(request.getParameter("destino"));
            int idTipoIngreso = Integer.parseInt(request.getParameter("idTipoIngreso"));
            String tarjetaVehiculo = request.getParameter("tarjetaVehiculo");
            String autorizacion = request.getParameter("autorizacion");
            String ingreso = request.getParameter("ingreso");
            String salida =  request.getParameter("salida");
            String observacion = request.getParameter("observacion");
            int tipoPersona = Integer.parseInt(request.getParameter("tipoPersona"));
            Visitas vis = new Visitas(idVisita);
            vis.setIdentificacion(identificacion);
            vis.setNombre(nombre);
            vis.setDestino(destino);
            vis.setIdTipoIngreso(idTipoIngreso);
            vis.setTarjetaVehiculo(tarjetaVehiculo);
//            vis.setAutorizacion(autorizacion);
            vis.setIngreso(ingreso);
            vis.setSalida(salida);
            vis.setObservacion(observacion);
            vis.setTipoPersona(tipoPersona);
            if (vis.actualizarVisita()) {
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