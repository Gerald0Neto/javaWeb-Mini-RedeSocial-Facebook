package filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/recebe.jsp")
public class AuthFilter implements Filter{

	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

 
        HttpSession session = req.getSession(false);


        if (session == null || session.getAttribute("usuarioId") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

}
