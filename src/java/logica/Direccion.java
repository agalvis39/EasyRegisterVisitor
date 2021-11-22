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
public class Direccion {
    private int idDireccion;
    private String direccion;

    public Direccion() {
    }

    public Direccion(int idDireccion, String direccion) {
        this.idDireccion = idDireccion;
        this.direccion = direccion;
    }

    public Direccion(int idDireccion) {
        this.idDireccion = idDireccion;
    }

    public int getIdDireccion() {
        return idDireccion;
    }

    public void setIdDireccion(int idDireccion) {
        this.idDireccion = idDireccion;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    @Override
    public String toString() {
        return "Direccion{" + "idDireccion=" + idDireccion + ", Direccion=" + direccion + '}';
    }
    
    public Direccion consultarDirecciones() {
        Direccion listaDireccion = new Direccion();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT *"
                + "FROM direccion;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
//            Direccion dir;
            if (rs.next()) {
//                dir = new Direccion();
                this.idDireccion = rs.getInt("idDireccion");
                this.direccion = rs.getString("direccion");
                
                
            }else{
                return null;
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return this;

    }
    public Direccion consultaIndividualDireccion(){
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM direccion WHERE direccion LIKE "+"%'"+this.direccion+"'%"+"OR idDireccion="+this.idDireccion+"";
        ResultSet rs = conexion.consultarBD(sql);
        
        try {
            if(rs.next()){
                this.idDireccion = rs.getInt("idDireccion");
                this.direccion = rs.getString("direccion");
            }else{
                return null;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }finally{
            conexion.cerrarConexion();
        }
        return this;
    }
    public boolean guardarDireccion() {
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO direccion\n"
                + "(direccion)\n"
                + "VALUES('" + this.direccion + "');";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();// restaura base de datos sin perder valore
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;

        }
    }

    public boolean actualizarDireccion() {
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE direccion\n"
                + "SET direccion='" + this.direccion + "'\n"
                + "WHERE idDireccion=" + this.idDireccion + ";";

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
