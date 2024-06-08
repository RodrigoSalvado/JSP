<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    boolean alterado = false;

    // Inicialização de variaveis para alteração de dados de um utilizador
    int curso = request.getParameter("curso")==null? 0: Integer.parseInt(request.getParameter("curso"));
    int id_curso = request.getParameter("id_curso")==null? -1: Integer.parseInt(request.getParameter("id_curso"));







    // Inicialização de variaveis para alteração de dados de um utilizador

    int utilizador = request.getParameter("utilizador")==null? 0: Integer.parseInt(request.getParameter("utilizador"));


    String nUsername = request.getParameter("username") == ""? null: request.getParameter("username");
    String nEmail = request.getParameter("email") == ""? null: request.getParameter("email");
    String nPass = request.getParameter("pass") == ""? null: request.getParameter("pass");
    int nTipo_utilizador = request.getParameter("tipo_utilizador") == null? -1: Integer.parseInt(request.getParameter("tipo_utilizador"));


    if(utilizador == 1){

        int id_utilizador = request.getParameter("id")==null? 0: Integer.parseInt(request.getParameter("id"));
        out.println(id_utilizador+"<br>");

        sql = "SELECT * FROM utilizador WHERE id_utilizador = "+ id_utilizador +";";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        if(rsSql.next()) {
            String username = rsSql.getString("username");
            String email = rsSql.getString("email");
            String password = rsSql.getString("password");
            int tipo_utilizador = rsSql.getInt("tipo_utilizador");

            out.println(username + "<br>");
            out.println(email + "<br>");
            out.println(password + "<br>");
            out.println(tipo_utilizador + "<br>");

            out.println("<br>");

            out.println(nUsername + "<br>");
            out.println(nEmail + "<br>");
            out.println(nPass + "<br>");
            out.println(nTipo_utilizador + "<br>");

            if(!username.equals(nUsername) && nUsername != null){
                sql = "SELECT * FROM utilizador WHERE username = '"+nUsername+"'";
                psSql = conn.prepareStatement(sql);
                rsSql = psSql.executeQuery();

                if(rsSql.next()){
                    out.println("<script>window.alert('Esse username já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script>");
                }else{
                    sql = "UPDATE utilizador SET username = '"+nUsername+"' WHERE id_utilizador = "+id_utilizador+";";
                    psSql = conn.prepareStatement(sql);
                    psSql.executeUpdate();

                    if(user.equals(username)){
                        session.setAttribute("username", nUsername);
                    }

                    alterado = true;
                }
            }

            if(!email.equals(nEmail) && nEmail != null){
                sql = "SELECT * FROM utilizador WHERE email = '"+nEmail+"'";
                psSql = conn.prepareStatement(sql);
                rsSql = psSql.executeQuery();

                if(rsSql.next()){
                    out.println("<script>window.alert('Esse email já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script>");
                }else{
                    sql = "UPDATE utilizador SET email = '"+nEmail+"' WHERE id_utilizador = "+id_utilizador+";";
                    psSql = conn.prepareStatement(sql);
                    psSql.executeUpdate();

                    alterado = true;
                }
            }

            if(!password.equals(nPass) && nPass != null){
                sql = "UPDATE utilizador SET password = '"+nPass+"' WHERE id_utilizador = "+id_utilizador+";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                alterado = true;
            }



            if(nTipo_utilizador != tipo_utilizador && nTipo_utilizador != -1){
                sql = "UPDATE utilizador SET tipo_utilizador = "+nTipo_utilizador+" WHERE id_utilizador = "+id_utilizador+";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                if(user.equals(username)){
                    session.setAttribute("tipo_utilizador", nTipo_utilizador);
                }

                alterado = true;
            }

            if(alterado){
                if(tipo == 4 && (!user.equals(username))){
                    out.println("<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoUtilizadores.php';</script>");
                }else{
                    out.println("<script>window.alert('Dados alterados com sucesso!') ; window.location.href = 'perfil.jsp';</script>");
                }
            }else{
                out.println("<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script");
            }
        }


    }


%>
