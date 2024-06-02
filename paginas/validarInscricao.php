<?php
global $conn;
include "../basedados/basedados.h";

try{
    $id = $_GET["id"];
    $validado = $_GET["validar"];
    $curso = $_GET["curso"];
}catch (Exception $e){

}

if($validado == 1){
    $sql = "UPDATE util_curso SET aceite = 1 WHERE curso = '$curso' AND id_utilizador = '$id'";
    mysqli_query($conn, $sql);
    header("Location: gestaoInscricoes.php");

}else{
    $sql = "DELETE FROM util_curso WHERE id_utilizador = $id AND curso = '$curso'";
    mysqli_query($conn, $sql);

    header("Location: gestaoInscricoes.php");
}
mysqli_close($conn);