<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="../basedados/basedados.h"%>

<%
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");

    out.println(user+"<br>");
    out.println(pass+"<br>");

    String sql = "SELECT * FROM utilizador WHERE username = ? AND password = ?";
    PreparedStatement psSql = conn.prepareStatement(sql);
    psSql.setString(1, user);
    psSql.setString(2, pass);
    ResultSet rsSql = psSql.executeQuery();

    out.println("query");

    if(rsSql.next()) {
        out.println("entrou");
        if(rsSql.getInt("tipo_utilizador")!=1){
            out.println("entrou");
            session.setAttribute("username", user);
            session.setAttribute("tipo_utilizador", rsSql.getInt("tipo_utilizador"));
            out.println("<script>window.alert('Fez Login!'); window.location.href = './paginaPrincipal.jsp'</script>");
        }else{
            out.println("<script>window.alert('A sua conta ainda não foi validada!'); window.location.href = './login.html'</script>");
        }
    }else{
        out.println("<script>window.alert('Dados inválidos!'); window.location.href = './login.html'</script>");
    }


%>




