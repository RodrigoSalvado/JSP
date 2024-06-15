<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    // protecao pagina/script
    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }else{


        // Verifica se algum dado foi alterado
        boolean alterado = false;

        // Vê se estamos a atualizar um curso
        int curso = request.getParameter("curso")==null? 0: Integer.parseInt(request.getParameter("curso"));


        // Vê se estamos a atualizar um utilizador
        int utilizador = request.getParameter("utilizador")==null? 0: Integer.parseInt(request.getParameter("utilizador"));




        if(utilizador == 1){

            // vai buscar os valores dos inputs
            String nUsername = request.getParameter("username") == ""? null: request.getParameter("username");
            String nEmail = request.getParameter("email") == ""? null: request.getParameter("email");
            String nPass = request.getParameter("pass") == ""? null: request.getParameter("pass");
            int nTipo_utilizador = (request.getParameter("tipo_utilizador") == null || request.getParameter("tipo_utilizador") == "")? -1: Integer.parseInt(request.getParameter("tipo_utilizador"));
            String[] cursos = request.getParameterValues("cursos") == null ? new String[] {"vazio"} : request.getParameterValues("cursos");


            int id_utilizador = request.getParameter("id_utilizador")==null? 0: Integer.parseInt(request.getParameter("id_utilizador"));


            // Vai buscar os valores atuais da bd do utilizador

            sql = "SELECT * FROM utilizador WHERE id_utilizador = "+ id_utilizador +";";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            if(rsSql.next()) {
                String username = rsSql.getString("username");
                String email = rsSql.getString("email");
                String password = rsSql.getString("password");
                int tipo_utilizador = rsSql.getInt("tipo_utilizador");

                // Comparar o novo username com o antigo
                if(!username.equals(nUsername) && nUsername != null){

                    // Verifica se já existe alguém com o novo username
                    sql = "SELECT * FROM utilizador WHERE username = '"+nUsername+"'";
                    psSql = conn.prepareStatement(sql);
                    rsSql = psSql.executeQuery();

                    if(rsSql.next()){
                        out.println("<script>window.alert('Esse username já existe!') ; window.location.href = 'gerirDados.jsp?utilizador=1&id_utilizador="+id_utilizador+"';</script>");
                    }else{

                        // Atualiza o username da tabela utilizador e atualiza o docente, caso o utilizador seja um

                        sql = "UPDATE curso SET docente = '"+nUsername+"' WHERE docente = (SELECT username FROM utilizador WHERE id_utilizador = "+id_utilizador+");";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        sql = "UPDATE utilizador SET username = '"+nUsername+"' WHERE id_utilizador = "+id_utilizador+";";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        // Se for a própria pessoa a trocar o seu username a variavel de sessao atualiza
                        if(user.equals(username)){
                            session.setAttribute("username", nUsername);
                        }

                        username = nUsername;
                        alterado = true;
                    }
                }


                // Compara o novo email com o atual
                if(!email.equals(nEmail) && nEmail != null){

                    // Vê se o novo email já existe na bd
                    sql = "SELECT * FROM utilizador WHERE email = '"+nEmail+"'";
                    psSql = conn.prepareStatement(sql);
                    rsSql = psSql.executeQuery();

                    if(rsSql.next()){
                        out.println("<script>window.alert('Esse email já existe!') ; window.location.href = 'gerirDados.jsp?utilizador=1&id_utilizador="+id_utilizador+"';</script>");
                    }else{
                        sql = "UPDATE utilizador SET email = '"+nEmail+"' WHERE id_utilizador = "+id_utilizador+";";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        alterado = true;
                    }
                }


                // Compara a password atual com a nova
                if(!password.equals(nPass) && nPass != null){
                    sql = "UPDATE utilizador SET password = '"+nPass+"' WHERE id_utilizador = "+id_utilizador+";";
                    psSql = conn.prepareStatement(sql);
                    psSql.executeUpdate();

                    alterado = true;
                }

                // Caso o admin inscreva o utilizador para um/vários cursos, caso não tenha este bloco é ignorado
                // A inscrição é automaticamente aprovada

                for(String insCurso: cursos){
                    if(!insCurso.equals("vazio")){
                        int id_curso = Integer.parseInt(insCurso);

                        sql = "SELECT c.max_num, COUNT(uc.id_inscricao) AS inscritos FROM curso c LEFT JOIN util_curso uc ON" +
                                " c.id_curso = uc.id_curso AND uc.aceite = 1 WHERE c.id_curso = "+id_curso+" GROUP BY c.id_curso;";
                        psSql = conn.prepareStatement(sql);
                        rsSql = psSql.executeQuery();

                        rsSql.next();

                        int total = rsSql.getInt("max_num");
                        int inscritos = rsSql.getInt("inscritos");

                        if(total > inscritos){
                            sql = "INSERT INTO util_curso (id_utilizador, id_curso, aceite) VALUES ("+id_utilizador+","+id_curso+","+1+")";
                            psSql = conn.prepareStatement(sql);
                            psSql.executeUpdate();
                        }else{
                            out.println("<script>window.alert('Não há mais vagas!') ; window.location.href = 'gerirDados.jsp?utilizador=1&id_utilizador="+id_utilizador+"';</script>");
                        }

                        alterado = true;
                    }
                }


                // Compara o cargo atual com o novo
                if(nTipo_utilizador != tipo_utilizador && nTipo_utilizador != -1){
                    sql = "UPDATE utilizador SET tipo_utilizador = "+nTipo_utilizador+" WHERE id_utilizador = "+id_utilizador+";";
                    psSql = conn.prepareStatement(sql);
                    psSql.executeUpdate();

                    // Caso o novo cargo nao seja um docente ou admin, verifica se o utilizador era um docente e atualiza o curso
                    if(nTipo_utilizador != 3 && nTipo_utilizador != 4){
                        sql = "UPDATE curso SET docente = '' WHERE docente = (SELECT username FROM utilizador WHERE id_utilizador = "+id_utilizador+")";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();
                    }

                    // Verifica se é o próprio utilizador a trocar os dados, e atualiza o seu cargo (só o admin usufrui disto!)
                    if(user.equals(username)){
                        session.setAttribute("tipo_utilizador", nTipo_utilizador);
                    }

                    alterado = true;
                }


                if(alterado){
                    if(tipo == 4 && (!user.equals(username))){ // Vê se é o admin a trocar dados de um utilizador
                        out.println("<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoUtilizadores.jsp';</script>");
                    }else{
                        out.println("<script>window.alert('Dados alterados com sucesso!') ; window.location.href = 'perfil.jsp';</script>"); // Próprio utilizador a trocar os dados
                    }
                }else{
                    out.println("<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.jsp?utilizador=1&id_utilizador="+id_utilizador+"';</script");
                }
            }


        }

        if(curso == 1){

            // vai buscar os valores dos inputs
            String nNome = request.getParameter("nome") == ""? null: request.getParameter("nome");
            String nDocente = request.getParameter("docente") == ""? null: request.getParameter("docente");
            String nDesc = request.getParameter("descricao") == ""? null: request.getParameter("descricao");
            int nMax_num = request.getParameter("max_num") == ""? -1: Integer.parseInt(request.getParameter("max_num"));
            String[] utilizadores = request.getParameterValues("utilizadores") == null ? new String[] {"vazio"} : request.getParameterValues("utilizadores");


            int id_curso = request.getParameter("id_curso") == null? -1: Integer.parseInt(request.getParameter("id_curso"));

            // Vai buscar os dados atuais do curso
            sql = "SELECT * FROM curso WHERE id_curso = "+ id_curso +";";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            if(rsSql.next()) {

                String docente = rsSql.getString("docente");
                String nome = rsSql.getString("nome");
                String descricao = rsSql.getString("descricao");
                int max_num = rsSql.getInt("max_num");

                // O admin tem acesso a todos os recursos
                if(tipo == 4) {

                    // Compara o docente com o novo docente
                    if(!docente.equals(nDocente) && nDocente != null){
                        sql = "UPDATE curso SET docente = '"+nDocente+"' WHERE id_curso = "+id_curso+";";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        alterado = true;
                    }

                    // Compara o nome do curso com o novo
                    if(!nome.equals(nNome) && nNome != null){

                        // Verifica se o novo nome já existe
                        sql = "SELECT * FROM curso WHERE nome = '"+nNome+"'";
                        psSql = conn.prepareStatement(sql);
                        rsSql = psSql.executeQuery();

                        if(rsSql.next()){
                            out.println("<script>window.alert('Esse nome para um curso já existe!') ; window.location.href = 'gerirDados.jsp?curso=1&id_curso="+id_curso+"';</script>");
                        }else{
                            sql = "UPDATE curso SET nome = '"+nNome+"' WHERE id_curso = "+id_curso+";";
                            psSql = conn.prepareStatement(sql);
                            psSql.executeUpdate();

                            alterado = true;
                        }
                    }

                    // Compara a descricao com a nova
                    if(!descricao.equals(nDesc) && nDesc != null){

                        // Verifica se a nova descricao já existe
                        sql = "SELECT * FROM curso WHERE descricao = '"+nDesc+"'";
                        psSql = conn.prepareStatement(sql);
                        rsSql = psSql.executeQuery();

                        if(rsSql.next()){
                            out.println("<script>window.alert('Essa descrição para um curso já existe!') ; window.location.href = 'gerirDados.jsp?curso=1&id_curso="+id_curso+"';</script>");
                        }else{
                            sql = "UPDATE curso SET descricao = '"+nDesc+"' WHERE id_curso = "+id_curso+";";
                            psSql = conn.prepareStatement(sql);
                            psSql.executeUpdate();

                            alterado = true;
                        }
                    }
                }

                //Recursos comuns ao docente e admin

                // Compara o max_num com o novo
                if(nMax_num != -1 && max_num != nMax_num){
                    if(nMax_num <= 0){
                        out.println("<script>window.alert('Aumente o limite de inscrições!') ; window.location.href = 'gerirDados.jsp?curso=1&id_curso="+id_curso+"';</script>");
                    }else{
                        sql = "UPDATE curso SET max_num = '"+nMax_num+"' WHERE id_curso = "+id_curso+";";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        alterado = true;
                    }
                }

                // Os utilizadores escolhidos são eliminados do curso
                for(String utilizadorIns: utilizadores){
                    if(!utilizadorIns.equals("vazio")){
                        int id_utilizador = Integer.parseInt(utilizadorIns);
                        sql = "DELETE FROM util_curso WHERE id_curso = "+id_curso+" AND id_utilizador = "+id_utilizador+";";
                        psSql = conn.prepareStatement(sql);
                        psSql.executeUpdate();

                        alterado = true;
                    }
                }

                if(alterado){
                    out.println("<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoCursos.jsp';</script>");
                }else{
                    out.println("<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.jsp?curso=1&id_curso="+id_curso+"';</script>");
                }

            }


        }
    }



    conn.close();
%>
