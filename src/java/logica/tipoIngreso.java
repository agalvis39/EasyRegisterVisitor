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
public class tipoIngreso {
    private int idTipoIngreso;
    private String tipoIngreso_1;

    public tipoIngreso(int idTipoIngreso, String tipoIngreso_1) {
        this.idTipoIngreso = idTipoIngreso;
        this.tipoIngreso_1 = tipoIngreso_1;
    }

    public tipoIngreso() {
    }

    public tipoIngreso(int idTipoIngreso) {
        this.idTipoIngreso = idTipoIngreso;
    }

    public int getIdTipoIngreso() {
        return idTipoIngreso;
    }

    public void setIdTipoIngreso(int idTipoIngreso) {
        this.idTipoIngreso = idTipoIngreso;
    }

    public String getTipoIngreso_1() {
        return tipoIngreso_1;
    }

    public void setTipoIngreso_1(String tipoIngreso_1) {
        this.tipoIngreso_1 = tipoIngreso_1;
    }

    @Override
    public String toString() {
        return "tipoIngreso{" + "idTipoIngreso=" + idTipoIngreso + ", tipoIngreso=" + tipoIngreso_1 + '}';
    }
    
    public List<tipoIngreso> consultarTiposDeIngreso() {
        List<tipoIngreso> listaTipoIngreso = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM tipoingreso;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            tipoIngreso tipo_Ingreso;
            while (rs.next()) {
                tipo_Ingreso = new tipoIngreso();
                tipo_Ingreso.setIdTipoIngreso(rs.getInt("idTipoIngreso"));
                tipo_Ingreso.setTipoIngreso_1(rs.getString("tipoIngreso"));
                
                listaTipoIngreso.add(tipo_Ingreso);
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaTipoIngreso;
    }

    public tipoIngreso consultarTipoIngresoIndividual() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM tipoingreso WHERE idTipoIngreso=" + this.idTipoIngreso + ";";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            if (rs.next()) {
                this.idTipoIngreso = rs.getInt("idTipoIngreso");
                this.tipoIngreso_1 = rs.getString("tipoIngreso");
                
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
