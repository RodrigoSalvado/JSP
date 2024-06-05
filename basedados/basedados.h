<%@ page language="java" import="java.sql.*" %>
<%
Connection conn = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
String jdbcURL="jdbc:mysql://localhost:3306/TrabalhoLPI";
conn = DriverManager.getConnection(jdbcURL,"root", "");
%>