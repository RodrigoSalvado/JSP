<?php
session_start();

if(isset($_POST["user"]) && isset($_POST["pass"])){

    //Dados do formulário
    $utilizador = $_POST["user"];
    $password = $_POST["pass"];
    global $conn;
    include '../basedados/basedados.h';
    include 'ConstUtilizadores.php';

    //==================================================================//
    //Selecionar user correspondente da base de dados
    $sql = "SELECT * FROM utilizador WHERE username = '$utilizador' AND password = '".md5($password)."' AND tipo_utilizador != ".APAGADO.";";
    $retval = mysqli_query( $conn, $sql );
    if(! $retval ){
        die('Could not get data: ' . mysqli_error($conn));// se não funcionar dá erro
    }
    $row = mysqli_fetch_array($retval);

    //==================================================================//
    if(strcmp($row["username"], $utilizador) == 0 && strcmp($row["password"], md5($password)) == 0){
        //=========================DADOS VÁLIDOS=========================//
        //Identifica o utilizador
        $_SESSION["user"] = $row["username"];
        $_SESSION["tipo"] = $row["tipo_utilizador"];
    }else{
        $_SESSION["user"] = -1;
        $_SESSION["tipo"] = -1;
    }
    echo "<div id='loading'>Loading...</div><script> setTimeout(function () { window.location.href = './secreta.php'; }, 1000)</script>";
}else{
    session_destroy();
    header("refresh:0;url = ./paginaPrincipal.php");

}
