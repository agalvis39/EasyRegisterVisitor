/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;

/**
 *
 * @author codes
 */
public class Visitas {

    private int idVisita;
    private int identificacion;
    private String nombre;
    private int destino;
    private int idTipoIngreso;
    private tipoIngreso tipoIngreso;
    private String tarjetaVehiculo;
    private int idAutorizacion;
    private Autorizacion autorizacion;
    private String ingreso;
    private String salida;
    private String observacion;
    private TipoPersona perfil;
    private int tipoPersona;

    public Visitas() {
    }

    public Visitas(int idVisita) {
        this.idVisita = idVisita;
    }

    public Visitas(int idVisita, int identificacion, String nombre, int destino, int idTipoIngreso, String tarjetaVehiculo, int idAutorizacion, String ingreso, String salida, String observacion, int tipoPersona) {
        this.idVisita = idVisita;
        this.identificacion = identificacion;
        this.nombre = nombre;
        this.destino = destino;
        this.idTipoIngreso = idTipoIngreso;
        this.tarjetaVehiculo = tarjetaVehiculo;
        this.idAutorizacion = idAutorizacion;
        this.ingreso = ingreso;
        this.salida = salida;
        this.observacion = observacion;
        this.tipoPersona = tipoPersona;
    }

    public int getIdVisita() {
        return idVisita;
    }

    public void setIdVisita(int idVisita) {
        this.idVisita = idVisita;
    }

    public int getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(int identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getDestino() {
        return destino;
    }

    public void setDestino(int destino) {
        this.destino = destino;
    }

    public int getIdTipoIngreso() {
        return idTipoIngreso;
    }

    public void setIdTipoIngreso(int idTipoIngreso) {
        this.idTipoIngreso = idTipoIngreso;
    }

    public tipoIngreso getTipoIngreso() {
        return tipoIngreso;
    }

    public void setTipoIngreso(tipoIngreso tipoIngreso) {
        this.tipoIngreso = tipoIngreso;
    }

    public String getTarjetaVehiculo() {
        return tarjetaVehiculo;
    }

    public void setTarjetaVehiculo(String tarjetaVehiculo) {
        this.tarjetaVehiculo = tarjetaVehiculo;
    }

    public int getIdAutorizacion() {
        return idAutorizacion;
    }

    public void setIdAutorizacion(int idAutorizacion) {
        this.idAutorizacion = idAutorizacion;
    }

    public Autorizacion getAutorizacion() {
        return autorizacion;
    }

    public void setAutorizacion(Autorizacion autorizacion) {
        this.autorizacion = autorizacion;
    }

    public String getIngreso() {
        return ingreso;
    }

    public void setIngreso(String ingreso) {
        this.ingreso = ingreso;
    }

    public String getSalida() {
        return salida;
    }

    public void setSalida(String salida) {
        this.salida = salida;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public TipoPersona getPerfil() {
        return perfil;
    }

    public void setPerfil(TipoPersona perfil) {
        this.perfil = perfil;
    }

    public int getTipoPersona() {
        return tipoPersona;
    }

    public void setTipoPersona(int tipoPersona) {
        this.tipoPersona = tipoPersona;
    }

    @Override
    public String toString() {
        return "Visitas{" + "idVisita=" + idVisita + ", identificacion=" + identificacion + ", nombre=" + nombre + ", destino=" + destino + ", idTipoIngreso=" + idTipoIngreso + ", tipoIngreso=" + tipoIngreso + ", tarjetaVehiculo=" + tarjetaVehiculo + ", idAutorizacion=" + idAutorizacion + ", autorizacion=" + autorizacion + ", ingreso=" + ingreso + ", salida=" + salida + ", observacion=" + observacion + ", perfil=" + perfil + ", tipoPersona=" + tipoPersona + '}';
    }

    

    
    
    
    

    

    public List<Visitas> consultarTodasLasVisitas() {
        List<Visitas> listaVisitas = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM visitas;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Visitas visita;
            while (rs.next()) {
                visita = new Visitas();
                visita.setIdVisita(rs.getInt("idVisita"));
                visita.setIdentificacion(rs.getInt("identificacion"));
                visita.setNombre(rs.getString("nombre"));
                visita.setDestino(rs.getInt("destino"));
                visita.setIdTipoIngreso(rs.getInt("tipoIngreso"));
                tipoIngreso tipo_ingreso = new tipoIngreso(visita.getIdTipoIngreso()).consultarTipoIngresoIndividual();
                visita.setTipoIngreso(tipo_ingreso);
                visita.setTarjetaVehiculo(rs.getString("tarjetaVehiculo"));
                visita.setIdAutorizacion(rs.getInt("idAutorizacion"));
                Autorizacion aut = new Autorizacion(visita.getIdAutorizacion()).consultarAutorizacionIndividual();
                visita.setAutorizacion(aut);
                visita.setIngreso(rs.getString("ingreso"));
                visita.setSalida(rs.getString("salida"));
                visita.setObservacion(rs.getString("observacion"));
                visita.setTipoPersona(rs.getInt("tipoPersona"));
                TipoPersona pfl = new TipoPersona(visita.getTipoPersona()).consultarTipoPersonaIndividual();
                visita.setPerfil(pfl);
                listaVisitas.add(visita);
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaVisitas;
    }

    public Visitas consultarVisita() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM visitas WHERE idVisita=" + this.idVisita + ";";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            if (rs.next()) {
                this.idVisita = rs.getInt("idVisita");
                this.identificacion = rs.getInt("identificacion");
                this.nombre = rs.getString("nombre");
                this.destino = rs.getInt("destino");
                this.idTipoIngreso = rs.getInt("tipoIngreso");
                tipoIngreso tipo_ingreso = new tipoIngreso(getIdTipoIngreso()).consultarTipoIngresoIndividual();
                this.tipoIngreso = tipo_ingreso;
                this.tarjetaVehiculo = rs.getString("tarjetaVehiculo");
                this.idAutorizacion = rs.getInt("idAutorizacion");
                this.ingreso = rs.getString("ingreso");
                this.salida = rs.getString("salida");
                this.observacion = rs.getString("observacion");
                this.tipoPersona = rs.getInt("tipoPresona");
            } else {
                return null;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

    public boolean guardarVisita() {
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO visitas\n"
                + "(identificacion, nombre, destino, tipoIngreso, tarjetaVehiculo, autorizacion, ingreso, salida, observacion, tipoPersona)\n"
                + "VALUES(" + this.identificacion + ", '" + this.nombre + "', " + this.destino + ", " + this.idTipoIngreso + ", '" + this.tarjetaVehiculo + "', '" + this.autorizacion + "', '" + this.ingreso + "', '" + this.salida + "', '" + this.observacion + "', " + this.tipoPersona + ");";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean actualizarVisita() {
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE visitas\n"
                + "SET identificacion=" + this.identificacion + ", nombre='" + this.nombre + "', destino=" + this.destino + ", tipoIngreso=" + this.idTipoIngreso + ", tarjetaVehiculo='" + this.tarjetaVehiculo + "', autorizacion='" + this.autorizacion + "', ingreso='" + this.ingreso + "', salida='" + this.salida + "', observacion='" + this.observacion + "', tipoPersona=" + this.tipoPersona + "\n"
                + "WHERE idVisita=" + this.idVisita + "";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean eliminarVisita() {
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM visitas\n"
                + "WHERE idVisita=" + this.idVisita + ";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }
}
