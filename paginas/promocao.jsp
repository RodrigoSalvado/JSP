<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

    int tipo = session.getAttribute("tipo_utilizador") == null ? 0 : (Integer) session.getAttribute("tipo_utilizador");

    if(tipo != 4){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }


    int promover = request.getParameter("promover") == null? 0: Integer.parseInt(request.getParameter("promover"));
    int id = request.getParameter("id") == null? 0: Integer.parseInt(request.getParameter("id"));

    int tipo_utilizador = 0;

    sql = "SELECT tipo_utilizador FROM utilizador WHERE id_utilizador = "+ id + ";";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();

    if(rsSql.next()){
        tipo_utilizador = rsSql.getInt("tipo_utilizador");
    }


    if(promover == 1){
        switch (tipo_utilizador) {
            case 4:
                out.println("<script>window.alert('Este utilizador já tem o cargo máximo') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                break;
            case 3:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 4 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Promoveu o utilizador para Administrador!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao promover o utilizador para Administrador!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
            case 2:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 3 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Promoveu o utilizador para Docente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao promover o utilizador para Docente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
            case 1:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 2 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Promoveu o utilizador para Aluno!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao promover o utilizador para Aluno!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
        }
    }else{
        switch (tipo_utilizador) {
            case 4:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 3 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Despromoveu o utilizador para Docente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao despromover o utilizador para Docente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
            case 3:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 2 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Despromoveu o utilizador para Aluno!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao despromover o utilizador para Aluno!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
            case 2:
                sql = "UPDATE utilizador SET tipo_utilizador = "+ 1 +" WHERE id_utilizador = "+ id +";";
                psSql = conn.prepareStatement(sql);
                rowsAffected = psSql.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>window.alert('Despromoveu o utilizador para Cliente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Erro ao despromover o utilizador para Cliente!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                }
                break;
            case 1:
                out.println("<script>window.alert('Este utilizador já tem o cargo minimo!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                break;
        }
    }


    conn.close();
%>





