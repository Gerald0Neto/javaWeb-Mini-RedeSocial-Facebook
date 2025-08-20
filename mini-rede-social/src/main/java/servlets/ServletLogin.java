package servlets;

import java.io.IOException;
import java.sql.SQLException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ModelLogin;


@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ModelLogin ModelLogin;
   
    public ServletLogin() {
        super();
    }

    public void init() {
    	ModelLogin  = new ModelLogin();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
	    if (session != null && session.getAttribute("usuarioId") != null) {
	        
	        response.sendRedirect("recebe.jsp");
	        return;
	    }
	    request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String senha = request.getParameter("senha");

	    if(email == null || email.isEmpty() || senha == null || senha.isEmpty()) {
	        request.setAttribute("msg", "Seu login e senha não foram informados");
	        request.getRequestDispatcher("index.jsp").forward(request, response);
	        return;
	    }

	    try {
	        boolean usuarioValido = ModelLogin.verificaUsuario(email, senha, request);
	        if (usuarioValido) {
	            // Redireciona para recebe.jsp em nova requisição
	            response.sendRedirect("recebe.jsp");
	        } else {
	            request.setAttribute("msg", "Usuário ou senha inválidos");
	            request.getRequestDispatcher("index.jsp").forward(request, response);
	        }
	    } catch (SQLException e) {
	        throw new ServletException(e);
	    }
	}

}
