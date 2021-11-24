package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;

public class Apartamentos {

    private int nApartamento;
    private String propietario;
    private String residente;
    private String torre;
    private String direccion;
    private int datafono;
    private String piso;

    public Apartamentos() {
    }

    public Apartamentos(int nApartamento) {
        this.nApartamento = nApartamento;
    }

    public Apartamentos(int nApartamento, String propietario, String residente, String torre, String direccion, int datafono, String piso) {
        this.nApartamento = nApartamento;
        this.propietario = propietario;
        this.residente = residente;
        this.torre = torre;
        this.direccion = direccion;
        this.datafono = datafono;
        this.piso = piso;
    }

    public int getnApartamento() {
        return nApartamento;
    }

    public void setnApartamento(int nApartamento) {
        this.nApartamento = nApartamento;
    }

    public String getPropetario() {
        return propietario;
    }

    public void setPropetario(String propietario) {
        this.propietario = propietario;
    }

    public String getResidente() {
        return residente;
    }

    public void setResidente(String residente) {
        this.residente = residente;
    }

    public String getTorre() {
        return torre;
    }

    public void setTorre(String torre) {
        this.torre = torre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getDatafono() {
        return datafono;
    }

    public void setDatafono(int datafono) {
        this.datafono = datafono;
    }

    public String getPiso() {
        return piso;
    }

    public void setPiso(String piso) {
        this.piso = piso;
    }

    @Override
    public String toString() {
        return "apartamentos{" + "nApartamento=" + nApartamento + ", propietario=" + propietario + ", residente=" + residente + ", torre=" + torre + ", direccion=" + direccion + ", datafono=" + datafono + ", piso=" + piso + '}';
    }

    public List<Apartamentos> consultaTodosApartamentos() {
        List<Apartamentos> listaApartamentos = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT *"
                + "FROM apartamentos ORDER BY nApartamento ASC;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Apartamentos apar;
            while (rs.next()) {
                apar = new Apartamentos();
                apar.setnApartamento(rs.getInt("nApartamento"));
                apar.setPropetario(rs.getString("propietario"));
                apar.setResidente(rs.getString("residente"));
                apar.setTorre(rs.getString("torre"));
                apar.setDireccion(rs.getString("direccion"));
                apar.setDatafono(rs.getInt("datafono"));
                apar.setPiso(rs.getString("piso"));
                listaApartamentos.add(apar);
            }
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaApartamentos;

    }
    
    public Apartamentos consultaIndividualApartamento(){
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM apartamentos WHERE nApartamento="+this.nApartamento+";";
        ResultSet rs = conexion.consultarBD(sql);
        
        try {
            if(rs.next()){
                this.nApartamento = rs.getInt("nApartamento");
                this.propietario = rs.getString("propietario");
                this.residente = rs.getString("residente");
                this.torre = rs.getString("torre");
                this.direccion = rs.getString("direccion");
                this.datafono = rs.getInt("datafono");
                this.piso = rs.getString("piso");
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

    public boolean guardarApartamento() {
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO apartamentos\n"
                + "(nApartamento, propietario, residente, torre, direccion, datafono, piso)\n"
                + "VALUES(" + this.nApartamento + ", '" + this.propietario + "', '" + this.residente + "', '" + this.torre + "', '" + this.direccion + "', " + this.datafono + ", '" + this.piso + "');";
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

    public boolean actualizarApartamento(int Apto) {
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE apartamentos\n"
                + "SET nApartamento=" + this.nApartamento + ", propietario='" + this.propietario + "', residente='" + this.residente + "', torre='" + this.torre + "', direccion='" + this.direccion + "', datafono=" + this.datafono + ", piso='" + this.piso + "'\n"
                + "WHERE nApartamento=" + Apto + ";";

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

    public boolean eliminarApartamento() {
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM apartamentos\n"
                + "WHERE nApartamento="+this.nApartamento+";";
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
