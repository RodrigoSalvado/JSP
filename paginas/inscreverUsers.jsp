<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

    int tipo = session.getAttribute("tipo_utilizador") == null ? 0 : (Integer) session.getAttribute("tipo_utilizador");

    // Protecao de pagina/script
    if (tipo == 1 || tipo == 0 || tipo == 2) {
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }else{
        int id_curso = Integer.parseInt(request.getParameter("id_curso"));

        // Vê os utilizadores selecionados pelas check-boxs, se nenhum foi selecionado o array fica array[0]="vazio"
        String[] utilizadores = request.getParameterValues("utilizadores") == null ? new String[] {"vazio"} : request.getParameterValues("utilizadores");

        // Inscrever os utilizadores
        for(String utilizador: utilizadores){
            if(!utilizador.equals("vazio")){
                int id_utilizador = Integer.parseInt(utilizador);
                sql = "INSERT INTO util_curso (id_utilizador, id_curso, aceite) VALUES ("+id_utilizador+","+id_curso+","+1+")";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();
            }
        }

        out.println("<script>window.alert('Utilizadores foram inscritos!') ; window.location.href = 'inscreverUtilizador.jsp?id_curso="+id_curso+"';</script>");
    }



    conn.close();
%>