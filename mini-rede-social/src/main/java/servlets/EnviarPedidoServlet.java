package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.Usuario;
import db.DB;


@WebServlet("/EnviarPedidoServlet")
public class EnviarPedidoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("destinatario");
        int usuarioLogadoId = (int) request.getSession().getAttribute("usuarioId");

        List<Usuario> usuarios = new ArrayList<>();
        
        try (Connection conn = DB.getConnection()) {
            String sql = "SELECT id, nome, email FROM usuarios WHERE nome LIKE ? AND id != ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, nome + "%");
            pst.setInt(2, usuarioLogadoId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                usuarios.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("usuariosEncontrados", usuarios);
        request.getRequestDispatcher("pedidos.jsp").forward(request, response);
    }
}
