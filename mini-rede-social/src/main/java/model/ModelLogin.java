package model;
import java.io.Serializable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import db.DB;


public class ModelLogin implements Serializable{
	
	private static final long serialVersionUID = 1L;

	public boolean verificaUsuario(String email, String senha, HttpServletRequest request) throws SQLException {
	    String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";

	    // Cada login cria uma nova conexão
	    try (Connection conn = DB.getConnection();
	         PreparedStatement pst = conn.prepareStatement(sql)) {

	        pst.setString(1, email);
	        pst.setString(2, senha);

	        try (ResultSet rs = pst.executeQuery()) {
	            if (rs.next()) {
	                int id = rs.getInt("id");
	                String nomeUser = rs.getString("nome");
	                String emailUser = rs.getString("email");

	                HttpSession session = request.getSession();
	                session.setAttribute("usuarioId", id);
	                session.setAttribute("nomeUser", nomeUser);
	                session.setAttribute("emailUser", emailUser);

	                return true;
	            }
	        }
	    }

	    return false; // nunca retorna null para boolean
	}	  
}
