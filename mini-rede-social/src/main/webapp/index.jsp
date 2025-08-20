<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }
        .login-container {
            height: 100vh;
            display: flex;
            justify-content: center;  
            align-items: center;    
            background-color: #f8f9fa;
        }
        .login-box {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-box">
        <h2 class="mb-4 text-center">Login</h2>
        <%
		    if (session != null && session.getAttribute("usuarioId") != null) {
		        response.sendRedirect("recebe.jsp");
		        return; 
		    }
		%>
        
        <form action="${pageContext.request.contextPath}/ServletLogin" method="POST">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input 
                    type="email" 
                    class="form-control" 
                    id="email" 
                    name="email" 
                    placeholder="Digite seu email" 
                />
            </div>

            <div class="mb-3">
                <label for="senha" class="form-label">Senha</label>
                <input 
                    type="password" 
                    class="form-control" 
                    id="senha" 
                    name="senha" 
                    placeholder="Digite sua senha" 
                />
            </div>

            <button type="submit" class="btn btn-primary w-100">Entrar</button>
        </form>
        
        <h5 class="mt-3 text-danger text-center">
            <%= request.getAttribute("msg") != null ? request.getAttribute("msg") : "" %>
        </h5>
    </div>
</div>

</body>
</html>
