<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    int id_curso = request.getParameter("curso") == null? 0: Integer.parseInt(request.getParameter("curso"));


    // Buscar o id do utilizador
    sql = "SELECT * FROM utilizador WHERE username = '"+ user +"';";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();

    rsSql.next();

    int id_utilizador = rsSql.getInt("id_utilizador");


    // Vê se é o docente do curso a inscrever-se nele
    sql = "SELECT * FROM curso WHERE id_curso = "+ id_curso + ";";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();
    rsSql.next();
    String docente = rsSql.getString("docente");
    if(docente.equals(user)){
        out.println("<script>window.alert('O docente não pode inscrever-se no seu curso!') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }else{

        // Vê se o utilizador já fez uma inscrição neste curso
        sql = "SELECT * FROM util_curso WHERE id_utilizador = "+ id_utilizador +" AND id_curso = "+ id_curso +";";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        if(rsSql.next()){
            out.println("<script>alert('Já fez uma inscrição para este curso!'); window.location.href = 'paginaPrincipal.jsp';</script>");
        }else{

            // Ver num inscritos no curso
            sql = "SELECT c.max_num, COUNT(uc.id_inscricao) AS inscritos FROM curso c LEFT JOIN util_curso uc ON c.id_curso = uc.id_curso GROUP BY c.id_curso";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            rsSql.next();

            int total = rsSql.getInt("max_num");
            int inscritos = rsSql.getInt("inscritos");

            if(total <= inscritos){
                out.println("<script>alert('Não há mais vagas para este curso!'); window.location.href = 'paginaPrincipal.jsp';</script>");
            }else{

                // Inscrever
                sql = "INSERT INTO util_curso (id_utilizador, id_curso, aceite) VALUES ("+id_utilizador+","+id_curso+","+0+")";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                out.println("<script>window.alert('Muito obrigado!\\\nAguarde até que a sua inscrição seja validada!') ; window.location.href = 'paginaPrincipal.jsp';</script>");
            }
        }
    }



    conn.close();

%>


