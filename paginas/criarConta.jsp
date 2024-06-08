<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ include file="../basedados/basedados.h" %>
<%
String user = request.getParameter("user");
String pass = request.getParameter("pass");
String email = request.getParameter("email");

try {
    //verifica se ja existe o user ou email
    sql ="SELECT * FROM utilizador WHERE username = '"+user+"' OR email = '"+email+"'";
    psSql =conn.prepareStatement(sql);
    rsSql =psSql.executeQuery();

    if(rsSql.next()){
        // Ver se é o user ou email (futuro)
        out.println("<script>window.alert('Username/email ja a ser usados!'); window.location.href = './login.html'</script>");
    }else{

        // Cria a conta
        sql = "INSERT INTO utilizador (username, password, email) VALUES ('"+user+"', '"+pass+"', '"+email+"')";
        psSql = conn.prepareStatement(sql);
        rowsAffected = psSql.executeUpdate();

        if(rowsAffected > 0){
            out.println("<script>window.alert('Conta criada com sucesso!'); window.location.href = './login.html'</script>");
        }else{
            out.println("<script>window.alert('Erro ao criar conta!'); window.location.href = './login.html'</script>");
        }

    }

}catch(Exception e){

}
    conn.close();
%>
