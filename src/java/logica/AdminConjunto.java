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
 * @author Diego
 */
public class AdminConjunto{

    private int identificacion;
    private String nombre;
    private String usuario;
    private String contrasena;

    public AdminConjunto() {
    }

    public AdminConjunto(int identificacion) {
        this.identificacion = identificacion;
    }

    public AdminConjunto(int identificacion, String nombre, String usuario, String contrasena) {
        this.identificacion = identificacion;
        this.nombre = nombre;
        this.usuario = usuario;
        this.contrasena = contrasena;
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

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

   
    @Override
    public String toString() {
        return "AdminConjunto{" + "identificacion=" + ", identificacion=" + identificacion + ", nombre=" + nombre + ", usuario=" + usuario + ", contrasena=" + contrasena +'}';
    }

    public List<AdminConjunto> consultarTodasLosAdminConjunto() {
        List<AdminConjunto> listaidentificacion = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM AdminConjunto;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            AdminConjunto ident;
            while (rs.next()) {
                ident = new AdminConjunto();
                ident.setIdentificacion(rs.getInt("identificacion"));
                ident.setNombre(rs.getString("nombre"));
                ident.setUsuario(rs.getString("usuario"));
                ident.setContrasena(rs.getString("contrasena"));
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaidentificacion;
    }

    public AdminConjunto consultarAdminConjunto() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM AdminConjunto WHERE identificacion=" + this.identificacion + ";";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            if (rs.next()) {
                this.identificacion = rs.getInt("identificacion");
                this.nombre = rs.getString("nombre");
                this.usuario = rs.getString("usuario");
                this.contrasena = rs.getString("contrasena");
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

    public boolean guardarAdminConjunto() {
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO AdminConjunto\n"
                + "(identificacion, nombre, usuario, contrasena)\n"
                + "VALUES(" + this.identificacion + ", '" + this.nombre + "', " + this.usuario + ", " + this.contrasena +");";
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

    public boolean actualizarAdminConjunto() {
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE AdminConjunto\n"
                + "SET identificacion=" + this.identificacion + ", nombre='" + this.nombre + "', usuario=" + this.usuario + ", contrasena=" + this.contrasena +"\n"
                + "WHERE identificacion=" + this.identificacion+ "";
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

    public boolean eliminarAdminConjunto() {
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM AdminConjunto\n"
                + "WHERE identificacion=" + this.identificacion + ";";
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