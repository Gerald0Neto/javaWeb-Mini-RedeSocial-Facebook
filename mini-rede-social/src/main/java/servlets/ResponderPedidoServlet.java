package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.Usuario;
import db.DB;

/**
 * Servlet implementation class ResponderPedidoServlet
 */
@WebServlet("/ResponderPedidoServlet")
public class ResponderPedidoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
    public ResponderPedidoServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int usuarioLogadoId = (int) request.getSession().getAttribute("usuarioId");
		List<Usuario> pedidos = new ArrayList<>();

		String sql = "SELECT a.id AS pedido_id, u.id AS usuario_id, u.nome, u.email " +
	             "FROM amigos a " +
	             "JOIN usuarios u ON a.usuario_id = u.id " +
	             "WHERE a.amigo_id = ? AND a.status = 'pendente'";


		try (Connection conn = DB.getConnection();
		     PreparedStatement pst = conn.prepareStatement(sql)) {

		    pst.setInt(1, usuarioLogadoId);
		    ResultSet rs = pst.executeQuery();

		    while (rs.next()) {
		        Usuario u = new Usuario();
		        u.setId(rs.getInt("usuario_id"));   
		        u.setNome(rs.getString("nome"));
		        u.setEmail(rs.getString("email"));
		        u.setPedidoId(rs.getInt("pedido_id")); 
		        pedidos.add(u);
		    }

		} catch (SQLException e) {
		    e.printStackTrace();
		}

		request.setAttribute("pedidosAmizade", pedidos);
		request.getRequestDispatcher("solicitacoes.jsp").forward(request, response);


	}

}
