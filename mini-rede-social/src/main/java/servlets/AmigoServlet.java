package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import classes.Usuario;

import db.DB;

@WebServlet("/AmigoServlet")
public class AmigoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usuarioLogadoId = (int) request.getSession().getAttribute("usuarioId");
        List<Usuario> amigos = new ArrayList<>();

        String sql = "SELECT u.id, u.nome, u.email FROM amigos a JOIN usuarios u ON a.usuario_id = u.id WHERE a.amigo_id = ? AND a.status = 'aceito'";

        try (Connection conn = DB.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, usuarioLogadoId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                amigos.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("listadeAmigos", amigos);
        request.getRequestDispatcher("amigoonline.jsp").forward(request, response);;
    }
}
