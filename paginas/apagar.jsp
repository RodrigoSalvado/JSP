<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

    // Protecao de pagina/script
    int tipo = session.getAttribute("tipo_utilizador") == null ? 0 : (Integer) session.getAttribute("tipo_utilizador");

    if (tipo != 4) {
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }else{
        // Verificar se estamos a apagar dados de um utilizador ou de um curso
        int utilizador = request.getParameter("id_utilizador") == null ? 0 : Integer.parseInt(request.getParameter("id_utilizador"));
        int curso = request.getParameter("id_curso") == null ? 0 : Integer.parseInt(request.getParameter("id_curso"));

        if(utilizador != 0){
            // Vai buscar os dados atuais do utilizador
            sql = "SELECT * FROM utilizador WHERE id_utilizador = "+utilizador+";";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            rsSql.next();

            int tipo_utilizador = Integer.parseInt(rsSql.getString("tipo_utilizador"));
            String username = rsSql.getString("username");

            // Se tiver-mos a apagar um ALUNO, apagar dados da tabela:
            // Utilizador;
            // Util_curso;
            if(tipo_utilizador == 2){

                sql = "DELETE FROM utilizador WHERE id_utilizador = "+ utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                sql = "DELETE FROM util_curso WHERE id_utilizador = "+ utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                out.println("<script>window.alert('Utilizador "+ username +" Apagado') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");

            }

            // Se tiver-mos a apagar um DOCENTE/ADMIN
            if(tipo_utilizador == 4 || tipo_utilizador == 3){

                // Ver se é docente em algum curso
                sql = "SELECT c.* FROM curso c JOIN utilizador u ON c.docente = u.username WHERE u.id_utilizador = "+utilizador+";";
                psSql = conn.prepareStatement(sql);
                rsSql = psSql.executeQuery();

                while(rsSql.next()) {

                    // Apagar o docente do curso

                    sql = "UPDATE curso SET docente = '' WHERE id_curso = "+rsSql.getInt("id_curso")+";";
                    psSql = conn.prepareStatement(sql);
                    psSql.executeUpdate();
                    out.println("<script>window.alert('Curso: "+rsSql.getString("nome")+" ficou sem docente!') ;</script>");
                }

                // Apagar dados da tabela:
                // Utilizador;
                // Util_curso -> caso tenha se registado num curso

                sql = "DELETE FROM util_curso WHERE id_utilizador = "+ utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                sql = "DELETE FROM utilizador WHERE id_utilizador = "+ utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                out.println("<script>window.alert('Utilizador "+ username +" Apagado!') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
            }

            // Se for CLIENTE apaga a conta
            if(tipo_utilizador == 1){
                sql = "DELETE FROM utilizador WHERE id_utilizador = "+ utilizador +";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                out.println("<script>window.alert('Cliente "+ utilizador + " Apagado') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
            }


        }

        // Apaga o curso da bd e todos os registos relacionados ao mesmo

        if(curso != 0){
            sql = "DELETE FROM curso WHERE id_curso = "+ curso +";";
            psSql = conn.prepareStatement(sql);
            psSql.executeUpdate();

            sql = "DELETE FROM util_curso WHERE id_curso = "+ curso +";";
            psSql = conn.prepareStatement(sql);
            psSql.executeUpdate();

            out.println("<script>window.alert('Curso Apagado') ; window.location.href = 'gestaoCursos.php';</script>");
        }
    }





    conn.close();


%>




