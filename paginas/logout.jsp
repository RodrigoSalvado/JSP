<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    // Protecao de pagina/script
    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    session.invalidate();
    out.println("<script>window.alert('Deu logout!'); window.location.href = './paginaPrincipal.jsp'</script>");
%>