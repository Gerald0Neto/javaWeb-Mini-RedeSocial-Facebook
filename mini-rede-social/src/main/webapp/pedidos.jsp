<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="classes.Usuario" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Enviar Pedido</title>
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

<!-- Conteúdo central -->
<div class="content">
    <h3 class="mb-4">Enviar Pedido para Outro Usuário</h3>

    <div class="form-card">
        <form action="EnviarPedidoServlet" method="post">
            <div class="mb-3">
                <label for="destinatario" class="form-label">Nome do usuário</label>
                <input type="text" class="form-control" id="destinatario" name="destinatario" placeholder="Digite o nome" required>
            </div>
            <button type="submit" class="btn btn-primary"><i class="bi bi-search me-1"></i>Pesquisar</button>
        </form>
    </div>

    <%
    @SuppressWarnings("unchecked")
    List<Usuario> usuariosEncontrados = (List<Usuario>) request.getAttribute("usuariosEncontrados");

    if (usuariosEncontrados != null && !usuariosEncontrados.isEmpty()) {
    %>
    <div class="mt-4">
        <h5>Resultados da pesquisa:</h5>
        <ul class="list-group">
        <%
            for (Usuario u : usuariosEncontrados) {
        %>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                    <strong><%= u.getNome() %></strong> <br>
                    <small class="text-secondary"><%= u.getEmail() %></small>
                </div>
                <form action="AdicionarAmigoServlet" method="post" class="m-0">
                    <input type="hidden" name="amigoId" value="<%= u.getId() %>">
                    <button type="submit" class="btn btn-sm btn-success"><i class="bi bi-person-plus me-1"></i>Adicionar</button>
                </form>
            </li>
        <%
            }
        %>
        </ul>
    </div>
    <%
    } else if (request.getAttribute("usuariosEncontrados") != null) {
    %>
    <p class="text-warning mt-3">Nenhum usuário encontrado.</p>
    <%
    }
    %>

</div>

<!-- Sidebar direita -->
<div class="rightbar">
    <h6 class="mb-3">Atalhos</h6>
    <div class="bg-dark p-2 rounded mb-2">
	  <a href="amigoonline.jsp" class="text-white text-decoration-none">Amigos Online</a>
	</div>
	
</div>

<%
} else {
    response.sendRedirect("index.jsp");
}
%>

<h5 class="mt-3 text-danger text-center">
    <%= request.getAttribute("msg") != null ? request.getAttribute("msg") : "" %>
</h5>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
