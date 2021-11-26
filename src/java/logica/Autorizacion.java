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
public class Autorizacion {
    private int idAutorizacion;
    private String Autorizacion;

    public Autorizacion(int idAutorizacion, String Autorizacion) {
        this.idAutorizacion = idAutorizacion;
        this.Autorizacion = Autorizacion;
    }

    public Autorizacion() {
    }

    public Autorizacion(int idAutorizacion) {
        this.idAutorizacion = idAutorizacion;
    }

    public int getIdAutorizacion() {
        return idAutorizacion;
    }

    public void setIdAutorizacion(int idAutorizacion) {
        this.idAutorizacion = idAutorizacion;
    }

    public String getAutorizacion() {
        return Autorizacion;
    }

    public void setAutorizacion(String Autorizacion) {
        this.Autorizacion = Autorizacion;
    }

    @Override
    public String toString() {
        return "tipoIngreso{" + "idTipoIngreso=" + idAutorizacion + ", tipoIngreso=" + Autorizacion + '}';
    }
    
    public List<Autorizacion> consultarAutorizacion() {
        List<Autorizacion> listaAutorizacion = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM autorizacion;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Autorizacion tipoAut;
            while (rs.next()) {
                tipoAut = new Autorizacion();
                tipoAut.setIdAutorizacion(rs.getInt("idAutorizacion"));
                tipoAut.setAutorizacion(rs.getString("Autorizacion"));
                
                listaAutorizacion.add(tipoAut);
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaAutorizacion;
    }

    public Autorizacion consultarAutorizacionIndividual() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM autorizacion WHERE idAutorizacion=" + this.idAutorizacion + ";";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            if (rs.next()) {
                this.idAutorizacion = rs.getInt("idAutorizacion");
                this.Autorizacion = rs.getString("Autorizacion");
                
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

    
}
