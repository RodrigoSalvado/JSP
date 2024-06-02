<?php
global $conn;
include "../basedados/basedados.h";
include "./ConstUtilizadores.php";

$promover = $_GET["promover"];
$id = $_GET["id"];

$sql = "SELECT tipo_utilizador FROM utilizador WHERE id_utilizador = '$id'";
$result = mysqli_query($conn, $sql);

if(mysqli_num_rows($result)>0){
    $row = mysqli_fetch_assoc($result);
    $tipoUtilizador = $row["tipo_utilizador"];
}

if($promover == 1){
    switch ($tipoUtilizador){
        case ADMINISTRADOR:
            echo "<script>alert('Este utilizador já tem o cargo máximo!')</script>";
            break;

        case DOCENTE:
            $sql = "UPDATE utilizador SET tipo_utilizador = 4 WHERE id_utilizador = '$id'";
            mysqli_query($conn, $sql);
            echo "<script>alert('Promoveu o utilizador para Admin!')</script>";
            header("Location: gestaoUtilizadores.php");
            break;

        case ALUNO:
            $sql = "UPDATE utilizador SET tipo_utilizador = 3 WHERE id_utilizador = '$id'";
            mysqli_query($conn, $sql);
            echo "<script>alert('Promoveu o utilizador para Docente!')</script>";
            header("Location: gestaoUtilizadores.php");
            break;

        case CLIENTE:
            $sql = "UPDATE utilizador SET tipo_utilizador = 2 WHERE id_utilizador = '$id'";
            mysqli_query($conn, $sql);
            echo "<script>alert('Promoveu o utilizador para Aluno!')</script>";
            header("Location: gestaoUtilizadores.php");
            break;
    }
}else {
    switch ($tipoUtilizador) {
        case ADMINISTRADOR:
            $sql = "UPDATE utilizador SET tipo_utilizador = 3 WHERE id_utilizador = '$id'";
            mysqli_query($conn, $sql);
            echo "<script>alert('Promoveu o utilizador para Docente!')</script>";
            header("Location: gestaoUtilizadores.php");
            break;

        case DOCENTE:
            $sql = "UPDATE utilizador SET tipo_utilizador = 2 WHERE id_utilizador = '$id'";
            mysqli_query($conn, $sql);
            echo "<script>alert('Promoveu o utilizador para Admin!')</script>";
            header("Location: gestaoUtilizadores.php");
            break;

        case ALUNO:
            echo "<script>alert('Este utilizador já tem o cargo minimo!')</script>";
            break;
    }
}

mysqli_close($conn);