<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="../basedados/basedados.h" %>
<%
String user = request.getParameter("user");
String pass = request.getParameter("pass");
String email = request.getParameter("email");
try {
      //verifica se ja existe o user ou email
//    String query = "SELECT COUNT(*) as total FROM utilizador WHERE username = ? OR email = ?";
//    PreparedStatement psSql = conn.prepareStatement(query);
//    psSql.setString(1, user);
//    psSql.setString(2, email);
//    ResultSet rsSql = psSql.executeQuery(query);

//    out.println(rsSql.getInt("total"));


    // Cria a conta
    String insert = "INSERT INTO utilizador (username, password, email) VALUES (?, ?, ?)";
    PreparedStatement pstmt = conn.prepareStatement(insert);
    pstmt.setString(1, user);
    pstmt.setString(2, pass);
    pstmt.setString(3, email);

    int row = pstmt.executeUpdate();

    if (row > 0) {
        //conta criada
        response.sendRedirect("./paginaPrincipal.jsp");
    } else {

        //conta nao criada
        out.println("<h2>Erro ao registrar utilizador.</h2>");
    }


}catch(Exception e){

}
    //

    conn.close();
%>
