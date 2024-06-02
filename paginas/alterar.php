<?php
session_start();
include "../basedados/basedados.h";
include "ConstUtilizadores.php";
global $conn;

try{
    $alterado = false;
    $curso = isset($_GET["curso"])? 1: 0;
    $utilizador = isset($_GET["utilizador"])? 1:0;
    $user = $_SESSION["user"];
}catch(Exception $e){

}

if($utilizador == 1){

    $id_utilizador = isset($_POST["nomeUser"])? $_POST["nomeUser"]: -1;

    $sql = "SELECT tipo_utilizador FROM utilizador WHERE id_utilizador = '$id_utilizador'";
    $result = mysqli_query($conn, $sql);
    if(mysqli_num_rows($result)){
        $row = mysqli_fetch_assoc($result);
        $tipo = $row["tipo_utilizador"];
    }

    $sql = "SELECT tipo_utilizador FROM utilizador WHERE username = '$user'";
    $result = mysqli_query($conn, $sql);
    if(mysqli_num_rows($result)){
        $row = mysqli_fetch_assoc($result);
        $tipoSessao = $row["tipo_utilizador"];
    }

    $sql = "SELECT username, email, id_utilizador, password FROM utilizador WHERE id_utilizador = '$id_utilizador'";
    $result = mysqli_query($conn, $sql);

    if($result && mysqli_num_rows($result) > 0){
        while($row = mysqli_fetch_assoc($result)){
            $username = $row["username"];
            $email = $row["email"];
            $id_utilizador = $row["id_utilizador"];
            $pass = $row["password"];


            if(isset($_POST["username"]) && strcmp($_POST["username"], $username) != 0){
                $novoUser = $_POST["username"];
                echo $novoUser."<br>";
            }
            if(isset($_POST["email"]) && strcmp($_POST["email"], $email) != 0){
                $novoEmail = $_POST["email"];
                echo $novoEmail."<br>";
            }

            if(isset($_POST["pass"]) && strcmp($_POST["pass"], $pass) != 0){
                $novaPass = md5($_POST["pass"]);
                echo $novaPass."<br>";
            }


        }
    }


    if(isset($_POST["botao"])){

        if(isset($novoUser)){
            $sqlCount = "SELECT username FROM utilizador WHERE username = '$novoUser'";
            $resultCount = mysqli_query($conn, $sqlCount);
            if(mysqli_num_rows($resultCount)>0){
                echo "<script>window.alert('Esse username já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id=".$id_utilizador."';</script>";
            }else{
                $sqlUser = "UPDATE utilizador SET username = '$novoUser' WHERE id_utilizador = '$id_utilizador'";
                mysqli_query($conn, $sqlUser);
                $alterado = true;
            }
        }
        if(isset($novoEmail)){
            $sqlCount = "SELECT email FROM utilizador WHERE email = '$novoEmail'";
            $resultCount = mysqli_query($conn, $sqlCount);

            if(mysqli_num_rows($resultCount)>0){
                echo "<script>window.alert('Esse Email já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id=".$id_utilizador."';</script>";
            }else{
                $sqlUser = "UPDATE utilizador SET  email = '$novoEmail' WHERE id_utilizador = '$id_utilizador'";
                mysqli_query($conn, $sqlUser);
                $alterado = true;
            }
        }
        if(isset($novaPass)){
            $sqlUser = "UPDATE utilizador SET password = '$novaPass' WHERE id_utilizador = '$id_utilizador'";
            mysqli_query($conn, $sqlUser);
            $alterado = true;
        }

        if ($alterado){
            if($tipo != ADMINISTRADOR && $tipoSessao == ADMINISTRADOR){
                echo "<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoUtilizadores.php';</script>";
            }else{
                echo "<script>window.alert('Dados alterados com sucesso!') ; window.location.href = 'login.html';</script>";
            }
        }else{
            echo "<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.php?utilizador=1&id=".$id_utilizador."';</script>";
        }

    }
}

if($curso == 1){
    $id_curso = $_GET["id_curso"];

    $sql = "SELECT * FROM curso WHERE id_curso = '$id_curso'";
    $result = mysqli_query($conn, $sql);

    if($result && mysqli_num_rows($result) > 0){
        while($row = mysqli_fetch_assoc($result)){
            $docente = $row["docente"];
            $nome = $row["nome"];
            $desc = $row["descricao"];
            $max_num = $row["max_num"];

            $sqlInscritos = "SELECT COUNT(*) as total FROM util_curso WHERE curso = '$nome'";
            $resultInscritos = mysqli_query($conn, $sqlInscritos);

            if(mysqli_num_rows($resultInscritos)>0){
                $rowInscritos = mysqli_fetch_assoc($resultInscritos);
                $inscritos = $rowInscritos["total"];
            }

            if(isset($_POST["docente"]) && strcmp($_POST["docente"], $docente) != 0){
                $novoDocente = $_POST["docente"];
                echo $novoDocente."<br>";
            }
            if(isset($_POST["nome"]) && strcmp($_POST["nome"], $nome) != 0){
                $novoNome = $_POST["nome"];
                echo $novoNome."<br>";
            }

            if(isset($_POST["descricao"]) && strcmp($_POST["descricao"], $desc) != 0){
                $novaDesc = $_POST["descricao"];
                echo $novaDesc."<br>";
            }

            if(isset($_POST["max_num"]) && $max_num != $_POST["max_num"]){
                $novoMaxNum = $_POST["max_num"];
                echo $novoMaxNum."<br>";
            }
        }
    }


    if(isset($_POST["botao"])){

        if(isset($novoDocente)){
            $sql = "UPDATE curso SET docente = '$novoDocente' WHERE id_curso = '$id_curso'";
            mysqli_query($conn, $sql);
            $alterado = true;
        }
        if(isset($novoNome)){
            $sqlCount = "SELECT nome FROM curso WHERE nome = '$novoNome'";
            $resultCount = mysqli_query($conn, $sqlCount);

            if(mysqli_num_rows($resultCount)>0){
                echo "<script>window.alert('Esse curso já existe!') ; window.location.href = 'gerirDados.php?curso=1&id_curso=".$id_curso."';</script>";
            }else{
                $sql = "UPDATE curso SET  nome = '$novoNome' WHERE id_curso = '$id_curso'";
                mysqli_query($conn, $sql);

                $sql = "UPDATE util_curso SET curso = '$novoNome' WHERE curso = '$nome'";
                mysqli_query($conn, $sql);

                $alterado = true;
            }

        }
        if(isset($novaDesc)){
            $sqlCount = "SELECT descricao FROM curso WHERE descricao = '$novaDesc'";
            $resultCount = mysqli_query($conn, $sqlCount);

            if(mysqli_num_rows($resultCount)>0){
                echo "<script>window.alert('Essa descrição já existe!') ; window.location.href = 'gerirDados.php?curso=1&id_curso=".$id_curso."';</script>";
            }else{
                $sql = "UPDATE curso SET  descricao = '$novaDesc' WHERE id_curso = '$id_curso'";
                mysqli_query($conn, $sql);
                $alterado = true;
            }
        }
        if(isset($novoMaxNum)){

            if($novoMaxNum <= 0){
                echo "<script>window.alert('Aumente o limite de inscrições!') ; window.location.href = 'gerirDados.php?curso=1&id_curso=".$id_curso."';</script>";
            }else{
                $sql = "UPDATE curso SET max_num = '$novoMaxNum' WHERE id_curso = '$id_curso'";
                mysqli_query($conn, $sql);
                $alterado = true;
            }
        }

        if ($alterado){
            echo "<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoCursos.php';</script>";
        }else{
            echo "<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.php?curso=1&id_curso=$id_curso';</script>";
        }

    }
}
mysqli_close($conn);
?>