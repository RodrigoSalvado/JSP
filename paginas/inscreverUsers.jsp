<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

    int id_curso = Integer.parseInt(request.getParameter("id_curso"));

    String[] utilizadores = request.getParameterValues("utilizadores") == null ? new String[] {"vazio"} : request.getParameterValues("utilizadores");

    for(String utilizador: utilizadores){
    if(!utilizador.equals("vazio")){
    int id_utilizador = Integer.parseInt(utilizador);
    sql = "INSERT INTO util_curso (id_utilizador, id_curso, aceite) VALUES ("+id_utilizador+","+id_curso+","+1+")";
    psSql = conn.prepareStatement(sql);
    psSql.executeUpdate();
    }
    }

    out.println("<script>window.alert('Utilizadores foram inscritos!') ; window.location.href = 'inscreverUtilizador.jsp?id_curso="+id_curso+"';</script>");
%>