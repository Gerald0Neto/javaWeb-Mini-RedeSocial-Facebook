<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="classes.Usuario" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Pedidos de Amizade</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    body { background-color: #18191a; color: white; }
    .navbar { background-color: #242526; }
    .sidebar {
        position: fixed;
        top: 56px; /* altura navbar */
        left: 0;
        width: 220px;
        height: 100%;
        background-color: #242526;
        padding: 15px;
        overflow-y: auto;
    }
    .container {
        margin-top: 80px;
        margin-left: 240px; /* espaço da sidebar */
    }
    .pedido-card {
        background-color: #3a3b3c;
        padding: 15px;
        border-radius: 12px;
        margin-bottom: 15px;
        transition: transform 0.2s;
    }
    .pedido-card:hover {
        transform: scale(1.02);
    }
    .btn-success {
        background-color: #42b72a;
        border-color: #42b72a;
    }
    .btn-success:hover {
        background-color: #36a420;
        border-color: #36a420;
    }
    .btn-primary {
        background-color: #1877f2;
        border-color: #1877f2;
    }
    .btn-primary:hover {
        background-color: #145dbf;
        border-color: #145dbf;
    }
    .form-control {
        background-color: #3a3b3c;
        color: white;
        border: none;
    }
    .form-control::placeholder {
        color: #ddd;
    }
    .sidebar a {
        display: block;
        color: white;
        text-decoration: none;
        margin-bottom: 12px;
        font-weight: 500;
    }
    .sidebar a:hover {
        color: #42b72a;
    }
    .sidebar-end {
    width: 220px;
    background-color: #242526;
    height: 100vh;
    overflow-y: auto;
    padding: 15px;
}
.sidebar-end h6 {
    color: white;
    font-weight: bold;
}
.sidebar-end .bg-dark {
    background-color: #3a3b3c !important;
}
</style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-dark fixed-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-facebook fs-3"></i></a>
        <form class="d-none d-md-flex w-50">
            <input class="form-control form-control-sm me-2" type="search" placeholder="Pesquisar no Facebook">
        </form>
        <div class="d-flex align-items-center">
            <a href="recebe.jsp" class="text-white mx-2"><i class="bi bi-house-door-fill fs-5"></i></a>
            <a href="#" class="text-white mx-2"><i class="bi bi-shop fs-5"></i></a>
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
        <strong>Seu Nome</strong>
    </div>
    <a href="logout.jsp" class="text-danger"><i class="bi bi-box-arrow-right me-2"></i>Sair</a>
    <hr class="text-secondary">
    <a href="#"><i class="bi bi-clock-history me-2"></i>Lembranças</a>
    <a href="#"><i class="bi bi-bookmark-fill me-2"></i>Salvos</a>
    <a href="#"><i class="bi bi-people-fill me-2"></i>Grupos</a>
    <a href="#"><i class="bi bi-bag-fill me-2"></i>Marketplace</a>
</div>



<!-- Conteúdo principal -->
<div class="container">
    <h3 class="mb-4">Pedidos de Amizade</h3>

    <!-- Botão para verificar solicitações -->
    <form action="ResponderPedidoServlet" method="post" class="mb-4">
        <button type="submit" class="btn btn-success">
            <i class="bi bi-person-check me-1"></i> Verificar Solicitações
        </button>
    </form>

<%
    @SuppressWarnings("unchecked")
    List<Usuario> pedidosAmizade = (List<Usuario>) request.getAttribute("pedidosAmizade");

    if (pedidosAmizade != null && !pedidosAmizade.isEmpty()) {
        for (Usuario u : pedidosAmizade) {
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
            <form action="AtualizarPedidoServlet" method="post" class="d-inline">
                <input type="hidden" name="pedidoId" value="<%= u.getPedidoId() %>">
                <button type="submit" name="acao" value="aceitar" class="btn btn-sm btn-primary me-1">Confirmar</button>
                <button type="submit" name="acao" value="rejeitar" class="btn btn-sm btn-secondary">Excluir</button>
            </form>
        </div>
    </div>
<%
        }
    } else {
%>
    <p class="text-warning">Nenhum pedido de amizade pendente.</p>
<%
    }
%>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
