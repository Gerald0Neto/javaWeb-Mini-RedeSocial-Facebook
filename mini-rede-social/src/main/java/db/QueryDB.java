package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class QueryDB {

	
	public static void insertUsuario(String nome, String email, String senha) {
	    String insert = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";

	    try (Connection conn = DB.getConnection();
	         PreparedStatement pst = conn.prepareStatement(insert)) {

	        pst.setString(1, nome);
	        pst.setString(2, email);
	        pst.setString(3, senha);

	        int rowsAffected = pst.executeUpdate();

	        if (rowsAffected > 0) {
	            System.out.println("Usuário inserido com sucesso!");
	        } else {
	            System.out.println("Nenhum usuário foi inserido.");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public static void selectUsuario() {
		String select = "SELECT * FROM usuarios";
		
		try(Connection conn = DB.getConnection();
			PreparedStatement st = conn.prepareStatement(select)) {
			st.executeQuery();
			}catch (Exception e) {
			// TODO: handle exception
		}
	}

}