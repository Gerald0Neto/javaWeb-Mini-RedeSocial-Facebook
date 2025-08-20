<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="classes.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listar de Amigos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    body { background-color: #18191a; color: white; }

    
    .navbar { background-color: #242526; }

    
    .sidebar {
        position: fixed;
        top: 56px;
        left: 0;
        width: 240px;
        height: 100%;
        background-color: #242526;
        padding: 20px;
        overflow-y: auto;
    }
    .sidebar a {
        display: block;
        color: white;
        text-decoration: none;
        margin-bottom: 12px;
        font-weight: 500;
    }
    .sidebar a:hover { color: #42b72a; }

    
    .content {
        margin-left: 260px;
        margin-right: 300px;
        padding-top: 70px;
    }

    
    .rightbar {
        position: fixed;
        top: 56px;
        right: 0;
        width: 280px;
        height: 100%;
        background-color: #242526;
        padding: 20px;
        overflow-y: auto;
    }

    
    .form-card {
        background-color: #3a3b3c;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
    }
    .form-control {
        background-color: #18191a;
        color: white;
        border: none;
    }
    .form-control::placeholder { color: #ccc; }

    
    .list-group-item {
        background-color: #3a3b3c;
        border: none;
        border-radius: 10px;
        margin-bottom: 10px;
        transition: transform 0.2s;
    }
    .list-group-item:hover { transform: scale(1.02); }

    
    .btn-primary {
        background-color: #1877f2;
        border-color: #1877f2;
    }
    .btn-primary:hover {
        background-color: #145dbf;
        border-color: #145dbf;
    }
    .btn-success {
        background-color: #42b72a;
        border-color: #42b72a;
    }
    .btn-success:hover {
        background-color: #36a420;
        border-color: #36a420;
    }  
</style>
</head>
<body>
<%
if(session != null && session.getAttribute("usuarioId") != null) {
    String nomeUser = (String) session.getAttribute("nomeUser");
    String emailUser = (String) session.getAttribute("emailUser");
%>
<!-- Navbar -->
<nav class="navbar navbar-dark fixed-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-facebook fs-3"></i></a>
        <form class="d-none d-md-flex w-50">
            <input class="form-control form-control-sm me-2" type="search" placeholder="Pesquisar">
        </form>
        <div class="d-flex align-items-center">
            <a href="recebe.jsp" class="text-white mx-2"><i class="bi bi-house-door-fill fs-5"></i></a>
            <a href="#" class="text-white mx-2"><i class="bi bi-chat-left-text-fill fs-5"></i></a>
            <a href="pedidos.jsp" class="text-white mx-2" title="Pedidos">
			  <i class="bi bi-people-fill fs-5"></i> 
			</a>
			<a href="solicitacoes.jsp" class="text-white mx-2" title="Solicitações de Amizade">
			  <i class="bi bi-person-plus-fill fs-5"></i> 
			</a>
            <img src="https://via.placeholder.com/32" class="rounded-circle ms-3" alt="perfil">
        </div>
    </div>
</nav>
<!-- Sidebar esquerda -->
<div class="sidebar">
    <div class="d-flex align-items-center mb-4">
        <img src="https://via.placeholder.com/40" class="rounded-circle me-2">
        <strong><%= nomeUser %></strong>
    </div>
    <p class="text-secondary mb-2"><%= emailUser %></p>
    <a href="logout.jsp" class="btn btn-sm btn-danger mb-3"><i class="bi bi-box-arrow-right me-1"></i>Sair</a>
    <hr class="text-secondary">
    <a href="#"><i class="bi bi-envelope-paper-fill me-2"></i>Meus Pedidos</a>
    <a href="#"><i class="bi bi-send-fill me-2"></i>Enviar Pedido</a>
</div>

<div class="content" >
    <h3 class="mb-4">Listar de Amigos</h3>
    
    <!-- Botão para verificar solicitações -->
    <form action="AmigoServlet" method="post" class="mb-4">
        <button type="submit" class="btn btn-success">
            <i class="bi bi-person-check me-1"></i> Verificar Amigos Conectados
        </button>
    </form>
    <%
    @SuppressWarnings("unchecked")
    List<Usuario> listaamigos = (List<Usuario>) request.getAttribute("listadeAmigos");
    
    	if(listaamigos != null && !listaamigos.isEmpty()){
    		for(Usuario u : listaamigos){
    %>	
    	<div class="pedido-card d-flex align-items-center justify-content-between">
	        <div class="d-flex align-items-center">
	            <img src="https://via.placeholder.com/50" class="rounded-circle me-3" alt="perfil">
	            <div>
	                <strong><%= u.getNome() %></strong><br>
	                <small class="text-secondary"><%= u.getEmail() %></small>
	            </div>
	        </div>
	        <div>
	        
	        <a href="chat.jsp" class="btn btn-sm btn-secondary">Conversa</a>

	            <form action="" method="post" class="d-inline">
	                <input type="hidden" name="pedidoId" value="<%= u.getPedidoId() %>">
	                <button type="submit" name="acao" value="rejeitar" class="btn btn-sm btn-secondary">Desvincular</button>
	            </form>
	        </div>
	    </div>
    <%
    		}
    	}
    %>
</div>    
    
<%
} else {
    response.sendRedirect("index.jsp");
}
%>
</body>
</html>