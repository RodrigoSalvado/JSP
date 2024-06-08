<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../basedados/basedados.h"%>

<%
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");


    sql = "SELECT * FROM utilizador WHERE username = '"+user+"' AND password = '"+pass+"';";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();


    if(rsSql.next()) {
        if(rsSql.getInt("tipo_utilizador")!=1){
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




