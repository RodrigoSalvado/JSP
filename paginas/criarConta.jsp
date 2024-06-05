<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="../basedados/basedados.h" %>
<%
String user = request.getParameter("user");
String pass = request.getParameter("pass");
String email = request.getParameter("email");

try {
    //verifica se ja existe o user ou email
    String sql ="SELECT * FROM utilizador WHERE username = ? OR email = ?";
    PreparedStatement psSql =conn.prepareStatement(sql);
    psSql.setString(1,user);
    psSql.setString(2,email);
    ResultSet rsSql =psSql.executeQuery();

    out.println(user + "<br>");
    out.println(email + "<br>");
    out.println(pass + "<br>");

    if(rsSql.next()){
        // Ver se é o user ou email (futuro)
        out.println("<script>window.alert('Username/email ja a ser usados!'); window.location.href = './login.html'</script>");
    }else{

        // Cria a conta
        String insert = "INSERT INTO utilizador (username, password, email) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setString(1, user);
        ps.setString(2, pass);
        ps.setString(3, email);

        ps.executeUpdate();

        out.println("<script>window.alert('Conta criada com sucesso!'); window.location.href = './login.html'</script>");
    }

}catch(Exception e){

}
    conn.close();
%>
