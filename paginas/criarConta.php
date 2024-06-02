<?php
global $conn;
include '../basedados/basedados.h';

$user = $_POST["user"];
$pass = $_POST["pass"];
$email = $_POST["email"];

$sql = "INSERT INTO `utilizador`(`username`, `password`, `email`) VALUES ('$user','".md5($pass)."','$email');";
//echo $sql;
$res = mysqli_query ($conn, $sql);
header ("Location:./paginaPrincipal.php");

mysqli_close($conn);