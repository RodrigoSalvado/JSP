<%
    session.invalidate();
    out.println("<script>window.alert('Deu logout!'); window.location.href = './paginaPrincipal.jsp'</script>");
%>