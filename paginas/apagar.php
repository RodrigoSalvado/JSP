<?php
global $conn;
include "../basedados/basedados.h";
include "./ConstUtilizadores.php";


$user = isset($_GET["user"])? $_GET["user"]:Null;
$curso = isset($_GET["curso"])? $_GET["curso"]:Null;

$sql = "SELECT id_curso FROM curso WHERE nome = '$curso'";
$result = mysqli_query($conn, $sql);

if(mysqli_num_rows($result)>0){
    $row = mysqli_fetch_assoc($result);
    $id_curso = $row["id_curso"];
}



if(isset($user)){
    $sql = "SELECT tipo_utilizador, id_utilizador FROM utilizador WHERE username = '$user'";
    $result = mysqli_query($conn, $sql);

    if(mysqli_num_rows($result)>0){
        $row = mysqli_fetch_assoc($result);
        $tipoUtilizador = $row["tipo_utilizador"];
        $id = $row["id_utilizador"];
    }

    if($tipoUtilizador == ALUNO){
        $sql = "DELETE FROM utilizador WHERE id_utilizador = '$id'";
        mysqli_query($conn, $sql);

        $sql = "DELETE FROM util_curso WHERE id_utilizador = '$id'";
        mysqli_query($conn, $sql);

        echo "<script>window.alert('Utilizador ".$user." Apagado') ; window.location.href = 'gestaoUtilizadores.php';</script>";
    }

    if($tipoUtilizador == DOCENTE || $tipoUtilizador == ADMINISTRADOR){
        $sql = "SELECT id_curso FROM curso WHERE docente = '$user'";
        $result = mysqli_query($conn, $sql);

        if(mysqli_num_rows($result)>0){
            $row = mysqli_fetch_assoc($result);
            $id_curso = $row["id_curso"];
        }

        $sql = "UPDATE curso SET docente = '' WHERE docente = '$user'";
        mysqli_query($conn, $sql);

        $sql = "DELETE FROM utilizador WHERE id_utilizador = '$id'";
        mysqli_query($conn, $sql);

        if(isset($id_curso)){
            echo "<script>window.alert('Utilizador ".$user." Apagado') ; window.location.href = 'gerirDados.php?curso=1&id_curso=$id_curso';</script>";
        }
        echo "<script>window.alert('Utilizador ".$user." Apagado') ; window.location.href = 'gestaoUtilizadores.php';</script>";
    }

    if($tipoUtilizador == CLIENTE){
        $sql = "DELETE FROM utilizador WHERE id_utilizador = '$id'";
        mysqli_query($conn, $sql);

        echo "<script>window.alert('Cliente ".$user." Apagado') ; window.location.href = 'gestaoUtilizadores.php';</script>";
    }
}

if(isset($curso)){
    $sql = "DELETE FROM curso WHERE nome = '$curso'";
    mysqli_query($conn, $sql);

    $sql = "DELETE FROM util_curso WHERE curso = '$curso'";
    mysqli_query($conn, $sql);

    echo "<script>alert('Curso ".$curso." Apagado')</script>";
    echo "<script>window.alert('Cliente ".$user." Apagado') ; window.location.href = 'gestaoCursos.php';</script>";
}


mysqli_close($conn);