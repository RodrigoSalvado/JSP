<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    // Protecao de pagina/script
    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }else{
        // Dados dos inputs
        int id_utilizador = request.getParameter("id_utilizador") == null? 0: Integer.parseInt(request.getParameter("id_utilizador"));
        int validado = request.getParameter("validar") == null? 0: Integer.parseInt(request.getParameter("validar"));
        int id_curso = request.getParameter("curso") == null? 0: Integer.parseInt(request.getParameter("curso"));

        if(validado == 1){

            sql = "SELECT c.max_num, COUNT(uc.id_inscricao) AS inscritos FROM curso c LEFT JOIN util_curso uc ON" +
                    " c.id_curso = uc.id_curso AND uc.aceite = 1 WHERE c.id_curso = "+id_curso+" GROUP BY c.id_curso;";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            rsSql.next();

            int total = rsSql.getInt("max_num");
            int inscritos = rsSql.getInt("inscritos");

            if(total > inscritos){

                sql = "UPDATE util_curso SET aceite = 1 WHERE id_curso = "+ id_curso +" AND id_utilizador = "+ id_utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                out.println("<script>window.alert('Aceitou a inscrição!') ; window.location.href = 'gestaoInscricoes.jsp';</script>");
            }else{

                out.println("<script>alert('Não há mais vagas para este curso!'); window.location.href = 'gestaoInscricoes.jsp';</script>");
            }

        }else{
            sql = "DELETE FROM util_curso WHERE id_utilizador = "+ id_utilizador +" AND id_curso = "+ id_curso +";";
            psSql = conn.prepareStatement(sql);
            psSql.executeUpdate();

            out.println("<script>window.alert('Recusou a inscrição!') ; window.location.href = 'gestaoInscricoes.jsp';</script>");
        }
    }



    conn.close();
%>


