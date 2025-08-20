<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="classes.Usuario" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Página do Usuário</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    body { background-color: #18191a; color: white; }

    
    .navbar { background-color: #242526; }

    
    .sidebar {
        position: fixed;
        top: 56px; /* altura da navbar */
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
        margin-left: 260px; /* espaço da sidebar */
        margin-right: 300px; /* espaço rightbar */
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

    
    .story {
        width: 120px;
        height: 200px;
        border-radius: 10px;
        background-color: #3a3b3c;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 14px;
        margin-right: 10px;
        cursor: pointer;
        transition: transform 0.2s;
    }
    .story:hover { transform: scale(1.05); }

    
    .feed-card {
        background-color: #3a3b3c;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        transition: transform 0.2s;
    }
    .feed-card:hover { transform: scale(1.02); }

    
    .form-control {
        background-color: #3a3b3c;
        color: white;
        border: none;
    }
    .form-control::placeholder { color: #ccc; }

    
    .btn-primary {
        background-color: #1877f2;
        border-color: #1877f2;
    }
    .btn-primary:hover {
        background-color: #145dbf;
        border-color: #145dbf;
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
            <input class="form-control form-control-sm me-2" type="search" placeholder="Pesquisar no Facebook">
        </form>
        <div class="d-flex align-items-center">
            <a href="recebe.jsp" class="text-white mx-2"><i class="bi bi-house-door-fill fs-5"></i></a>
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
    <a href="logout.jsp" class="text-danger"><i class="bi bi-box-arrow-right me-2"></i>Sair</a>
    <hr class="text-secondary">
    <a href="#"><i class="bi bi-clock-history me-2"></i>Lembranças</a>
    <a href="#"><i class="bi bi-bookmark-fill me-2"></i>Salvos</a>
    <a href="#"><i class="bi bi-people-fill me-2"></i>Grupos</a>
    <a href="#"><i class="bi bi-bag-fill me-2"></i>Marketplace</a>
</div>

<!-- Conteúdo central -->
<div class="content">

    <!-- Stories -->
    <div class="d-flex mb-4">
        <div class="story">Criar Story</div>
        <div class="story">Story 1</div>
        <div class="story">Story 2</div>
        <div class="story">Story 3</div>
    </div>

    <!-- Feed -->
    <div class="feed-card">
        <h6><strong>Socorro Oliveira</strong> está se sentindo abençoada</h6>
        <p>PAIZINHO, o Senhor é um GRANDE EXEMPLO...</p>
        <div class="mt-2">
            <button class="btn btn-primary btn-sm"><i class="bi bi-hand-thumbs-up me-1"></i>Curtir</button>
            <button class="btn btn-primary btn-sm"><i class="bi bi-chat-left-text me-1"></i>Comentar</button>
        </div>
    </div>

</div>

<!-- Rightbar -->
<div class="rightbar">
    <h6 class="mb-3">TEXTO</h6>
    <div id="pedidosAmizadeRightbar">
        <%-- Aqui você pode listar pedidos de amizade curtos --%>
    </div>
</div>

<%
} else {
    response.sendRedirect("index.jsp");
}
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
