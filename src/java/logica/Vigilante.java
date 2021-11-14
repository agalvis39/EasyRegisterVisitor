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
 * @author Juan Vásquez
 */
public class Vigilante {
    private int identificacion;
    private String nombre;
    private String usuario;
    private String contrasenia;

    public Vigilante() {
    }

    public Vigilante(int identificacion, String nombre, String usuario, String contrasenia) {
        this.identificacion = identificacion;
        this.nombre = nombre;
        this.usuario = usuario;
        this.contrasenia = contrasenia;
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

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    @Override
    public String toString() {
        return "Vigilante{" + "identificacion=" + identificacion + ", nombre=" + nombre + ", usuario=" + usuario + ", contrasenia=" + contrasenia + '}';
    }
    
    public List<Vigilante> consultarVigilantes () {
        List<Vigilante> listaVigilantes = new ArrayList<>();
        ConexionBD conexion = new ConexionBD ();
        String sql = "SELECT * FROM primeraprueba.vigilantes;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Vigilante v;
            while(rs.next()) {
                v = new Vigilante();
                v.setIdentificacion(rs.getInt(identificacion));
                v.setNombre(rs.getString(nombre));
                v.setUsuario(rs.getString(usuario));
                v.setContrasenia(rs.getString(contrasenia));
                listaVigilantes.add(v);
                
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        }finally {
            conexion.cerrarConexion();
        }
        
        return listaVigilantes;
    }
    
    public boolean guardarVigilante (){
        ConexionBD conexion = new ConexionBD ();
        String sql = "INSERT INTO primeraprueba.vigilantes (nombre, usuario, contrasenia) VALUES('"+this.nombre+"', '"+this.usuario+"', '"+this.contrasenia+"');";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)){
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
    
    public boolean actualizarVigilante (){
        ConexionBD conexion = new ConexionBD ();
        String sql = "UPDATE primeraprueba.vigilantes SET nombre='"+this.nombre+"', usuario='"+this.usuario+"', contrasenia='"+this.contrasenia+"' WHERE identificacion="+this.identificacion+";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)){
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
    
    public boolean eliminarVigilante (){
        ConexionBD conexion = new ConexionBD ();
        String sql = "DELETE FROM primeraprueba.vigilantes WHERE identificacion="+this.identificacion+";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)){
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
