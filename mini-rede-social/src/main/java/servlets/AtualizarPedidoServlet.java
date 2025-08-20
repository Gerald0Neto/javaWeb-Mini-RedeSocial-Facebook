package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DB;

@WebServlet("/AtualizarPedidoServlet")
public class AtualizarPedidoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AtualizarPedidoServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pedidoId = Integer.parseInt(request.getParameter("pedidoId"));
		String acao = request.getParameter("acao"); 
		String status = acao.equals("aceitar") ? "aceito" : "pendente"; 

		String sql = "UPDATE amigos SET status = ? WHERE id = ?";

		try (Connection conn = DB.getConnection();
		     PreparedStatement pst = conn.prepareStatement(sql)) {

		    pst.setString(1, status);
		    pst.setInt(2, pedidoId);
		    pst.executeUpdate();

		} catch (SQLException e) {
		    e.printStackTrace();
		}

		response.sendRedirect("recebe.jsp"); // Atualiza a página

	}

}
