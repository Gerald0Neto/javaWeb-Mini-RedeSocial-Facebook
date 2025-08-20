package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import db.DB;

@WebServlet("/AdicionarAmigoServlet")
public class AdicionarAmigoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		int userLogado = (int) request.getSession().getAttribute("usuarioId");
		int amigoId = Integer.parseInt(request.getParameter("amigoId"));
		
		String sqlpedido = "INSERT INTO amigos (usuario_id, amigo_id, status) VALUES (?, ?, 'pendente');";
		
		try(Connection conn = DB.getConnection()){
			PreparedStatement pst = conn.prepareStatement(sqlpedido);
			pst.setInt(1, userLogado);
			pst.setInt(2, amigoId);
			int linhas = pst.executeUpdate();
			
			if(linhas > 0){
				request.setAttribute("msg", "Solicitação de Amizada Enviada");
	            request.getRequestDispatcher("pedidos.jsp").forward(request, response);
		        System.out.println("Pedido de amizade enviado com sucesso!");
		    }else {
		    	request.setAttribute("msg", "Deu erro!");
	            request.getRequestDispatcher("pedidos.jsp").forward(request, response);
		    }
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
