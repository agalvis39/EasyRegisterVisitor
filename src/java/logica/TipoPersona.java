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
public class TipoPersona {
    private int idPersona;
    private String persona;

    public TipoPersona(int idPersona, String persona) {
        this.idPersona = idPersona;
        this.persona = persona;
    }

    public TipoPersona() {
    }

    public TipoPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getPersona() {
        return persona;
    }

    public void setPersona(String persona) {
        this.persona = persona;
    }

    @Override
    public String toString() {
        return "TipoPersona{" + "idPersona=" + idPersona + ", persona=" + persona + '}';
    }

    
    
    public List<TipoPersona> consultarTiposDePersona() {
        List<TipoPersona> listaTipoPersona = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM tipopersona;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            TipoPersona tipo_Persona;
            while (rs.next()) {
                tipo_Persona = new TipoPersona();
                tipo_Persona.setIdPersona(rs.getInt("idPersona"));
                tipo_Persona.setPersona(rs.getString("persona"));
                
                listaTipoPersona.add(tipo_Persona);
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaTipoPersona;
    }

    public TipoPersona consultarTipoPersonaIndividual() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM tipopersona WHERE idPersona=" + this.idPersona + ";";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            if (rs.next()) {
                this.idPersona = rs.getInt("idPersona");
                this.persona = rs.getString("persona");
                
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
