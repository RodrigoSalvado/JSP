<?php
session_start();

if(!isset($_SESSION["user"]) || !isset($_SESSION["tipo"])){
    $_SESSION["bt"] = "Página Login";
    $_SESSION["erro"] = "Algo não correu bem!!! Dirija-se para a Página de Login ou Registe-se";
    $_SESSION["dir"] = "./login.html";
    echo "<script>  setTimeout(function () { window.location.href = './Msg_erro.php'; }, 0000)</script>";

}else{
    include "./ConstUtilizadores.php";
    if($_SESSION["tipo"] == CLIENTE){

        $_SESSION["bt"] = "Voltar";
        $_SESSION["erro"] = "A sua conta ainda nao foi validada pelo nosso administrador!<br>Por favor, Tente mais tarde!";
        $_SESSION["dir"] = "./login.html";
        echo "<script>  setTimeout(function () { window.location.href = './Msg_erro.php'; }, 0000)</script>";

    }else if($_SESSION["user"]==-1 || $_SESSION["tipo"] == -1){

        $_SESSION["bt"] = "Voltar";
        $_SESSION["erro"] = "Combinação inválida!<br>Por favor, Preencha todos os campos corretamente.";
        $_SESSION["dir"] = "./login.html";
        echo "<script>  setTimeout(function () { window.location.href = './Msg_erro.php'; }, 0000)</script>";

    }else{
        echo " <script> alert ('Fez Login') </script>";
        echo "<script>  setTimeout(function () { window.location.href = 'paginaPrincipal.php'; }, 0000)</script>";
    }
}
