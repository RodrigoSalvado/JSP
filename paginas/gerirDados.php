<?php
include "../basedados/basedados.h";
include "ConstUtilizadores.php";
global $conn;
session_start();



try{
    $tipo = $_SESSION["tipo"];
    if($tipo == CLIENTE || empty($tipo)){
        echo "<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.php';</script>";
    }

    $curso = isset($_GET["curso"])? 1: 0;
    $utilizador = isset($_GET["utilizador"])? 1: 0;

}catch(Exception $e){

}

if($utilizador==1){
    //se for o proprio utilizador a aceder a pagina
    if(isset($_SESSION["user"])){
        $username = $_SESSION["user"];
        $sqlS = "SELECT email FROM utilizador WHERE username = '$username'";
        $resultS = mysqli_query($conn, $sqlS);

        if ($resultS && mysqli_num_rows($resultS) > 0) {
            $row = mysqli_fetch_assoc($resultS);
            $email = $row["email"];
        }
    }

    //se for o admin a aceder aos dados do utilizador
    if(isset($_GET["id"])){
        $id_utilizador = $_GET["id"];
    }

    $sql = "SELECT username, email, id_utilizador, password FROM utilizador WHERE id_utilizador = '$id_utilizador'";
    $result = mysqli_query($conn, $sql);

    if($result && mysqli_num_rows($result) > 0){
        while($row = mysqli_fetch_assoc($result)){
            $username = $row["username"];
            $email = $row["email"];
            $id_utilizador = $row["id_utilizador"];
            $pass = $row["password"];
        }
    }
}

if($curso==1){
    $id_curso = $_GET["id_curso"];
    $sql = "SELECT * FROM curso WHERE id_curso = '$id_curso'";
    $result = mysqli_query($conn, $sql);

    if(mysqli_num_rows($result)>0){
        $row = mysqli_fetch_assoc($result);

        $nome = $row["nome"];
        $docente = $row["docente"];
        $desc = $row["descricao"];
        $max_num = $row["max_num"];
    }

    $sqlInscritos = "SELECT COUNT(*) as total FROM util_curso WHERE curso = '$nome'";
    $resultInscritos = mysqli_query($conn, $sqlInscritos);

    if(mysqli_num_rows($resultInscritos)>0){
        $rowInscritos = mysqli_fetch_assoc($resultInscritos);
        $inscritos = $rowInscritos["total"];
    }

}

?>

<!DOCTYPE html>
<html>

<head>
    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="shortcut icon" href="favicon.png" type="">

    <title> Crypto Academy </title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="bootstrap.css" />

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">

    <!--owl slider stylesheet -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

    <!-- font awesome style -->
    <link href="font-awesome.min.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="responsive.css" rel="stylesheet" />

</head>

<body class="sub_page">

<div class="hero_area">

    <div class="hero_bg_box">
        <div class="bg_img_box">
            <img src="hero-bg.png" alt="">
        </div>
    </div>

    <!-- header section strats -->
    <header class="header_section">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg custom_nav-container ">
                <a class="navbar-brand" href="paginaPrincipal.php">
            <span>
              Crypto Academy
            </span>
                </a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class=""> </span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav  ">
                        <li class="nav-item active">
                            <a class="nav-link" href="paginaPrincipal.php">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.html"> About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cursos.php">Cursos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="why.html">Why Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="team.html">Team</a>
                        </li>

                        <?php
                        if(isset($_SESSION["user"])){
                            echo '
                                <li class="nav-item">
                                    <a class="nav-link" href="perfil.php">Perfil-'.$_SESSION["user"].'</a>
                                </li>
                             ';
                        }
                        ?>

                        <li class="nav-item">
                            <?php
                            if(isset($_SESSION["user"])){
                                echo '<a class="nav-link" href="logout.php"> <i class="fa fa-user" aria-hidden="true"></i> Logout</a>';
                            }else{
                                echo '<a class="nav-link" href="login.html"> <i class="fa fa-user" aria-hidden="true"></i> Login</a>';
                            }
                            ?>
                        </li>
                        <form class="form-inline">
                            <button class="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        </form>
                    </ul>
                </div>
            </nav>
        </div>
    </header>
    <!-- end header section -->
</div>

<!-- alterar dados -->

<?php

if($utilizador==1){
    echo '
        <div class="container-inscricao">
            <div class="informacoes">
                <form action="alterar.php?utilizador='.$utilizador.'" method="post" >
                    <input type="hidden" name="nomeUser" value="'.$id_utilizador.'">
                    <br>
                    <h3>Alterar informações pessoais</h3>
                    <br><br>
                    <label>Username:  '.$username.' </label>
                    <br>
                    <input type="text" name="username" placeholder="Novo username" value="'.$username.'" class="inp">
                    <br><br>
                    <label>Email: '.$email.'</label>
                    <br>
                    <input type="email" name="email" placeholder="Novo email" value="'.$email.'" class="inp">
                    <br><br>
                    <label>Password: ********** </label>
                    <br>
                    <input type="text" name="pass" placeholder="Nova password"  value="'.$pass.'" class="inp">
                    <br><br><br>
                    <input type="submit" value="Alterar dados" name="botao">
                    <br><br>
                </form>
            </div>
        </div>
    ';
}

if($curso==1){
   if($tipo == ADMINISTRADOR){
       echo '
        <div class="container-inscricao">
            <div class="informacoes">
                <form action="alterar.php?curso=1&id_curso='.$id_curso.'" method="post" >
                    <br>
                    <h3>Alterar Informações do Curso</h3>
                    <br><br>
                    <label>Nome: '.$nome.'</label>
                    <br>
                    <input type="text" name="nome" placeholder="Nome do curso..." value="'.$nome.'" class="inp" required>
                    <br><br>
                    <label>Docente: '.$docente.'</label>
                    <br>
                    <select name="docente" class="inp" required>';
       $sql = "SELECT username FROM utilizador WHERE tipo_utilizador = 3 OR tipo_utilizador = 4";
       $result = mysqli_query($conn, $sql);
       echo "<option>$docente</option>";
       if(mysqli_num_rows($result)>0){
           while($row = mysqli_fetch_assoc($result)){
               if(strcmp($row["username"],$docente)!=0){
                   echo "<option value='".$row['username']."'>".$row['username']."</option>";
               }

           }
       }
       echo'</select>
                    <br><br>
                    <label>Descrição do Curso:</label>
                    <br>
                    <textarea type="text" name="descricao" placeholder="Descrição do curso..." class="inp" required>'.$desc.'</textarea>
                    <br><br>
                    <label>Numero vagas: '.($max_num - $inscritos).'</label><br>
                    <label>Numero inscritos: '.$inscritos.'</label>
                    <br>
                    <input type="number" min="'.$inscritos.'" step="1" name="max_num" placeholder="Insira número de vagas..." value="'.$max_num.'" class="inp" required>
                    <br><br><br>
                    <input type="submit" value="Alterar Curso" name="botao">
                    <br><br>
                </form>
            </div>
        </div>
    ';
   }
   if($tipo == DOCENTE){
       echo '
        <div class="container-inscricao">
            <div class="informacoes">
                <form action="alterar.php?curso=1&id_curso='.$id_curso.'" method="post" >
                    <br>
                    <h3>Alterar Informações do Curso</h3>
                    <br><br>
                    <label>Nome: '.$nome.'</label>
                    <br>
                    <input type="hidden" name="nome" placeholder="Nome do curso..." value="'.$nome.'" class="inp">
                    <br><br>
                    <label>Docente: '.$docente.'</label>
                    <br>
                    <select name="docente" class="inp" hidden>';
                       $sql = "SELECT username FROM utilizador WHERE tipo_utilizador = 3 OR tipo_utilizador = 4";
                       $result = mysqli_query($conn, $sql);
                       echo "<option>$docente</option>";
                       if(mysqli_num_rows($result)>0){
                           while($row = mysqli_fetch_assoc($result)){
                               if(strcmp($row["username"],$docente)!=0){
                                   echo "<option value='".$row['username']."'>".$row['username']."</option>";
                               }

                           }
                       }
       echo'</select>
                    <br><br>
                    <label>Descrição do Curso:<br> '.$desc.'</label>
                    <br>
                    <textarea name="descricao" placeholder="Descrição do curso..." class="inp" hidden>'.$desc.'</textarea>
                    <br><br>
                    <label>Numero vagas: '.($max_num - $inscritos).'</label><br>
                    <label>Numero inscritos: '.$inscritos.'</label>
                    <br>
                    <input type="number" min="'.$inscritos.'" step="1" name="max_num" placeholder="Insira número de vagas..." value="'.$max_num.'" class="inp" required>
                    <br><br><br>
                    <input type="submit" value="Alterar Curso" name="botao">
                    <br><br>
                </form>
            </div>
        </div>
    ';
   }
}


?>

<!-- info section -->

<section class="info_section layout_padding2">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-3 info_col">
                <div class="info_contact">
                    <h4>
                        Address
                    </h4>
                    <div class="contact_link_box">
                        <a href="">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                            <span>
                  Location
                </span>
                        </a>
                        <a href="">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                            <span>
                  Call +01 1234567890
                </span>
                        </a>
                        <a href="">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                            <span>
                  demo@gmail.com
                </span>
                        </a>
                    </div>
                </div>
                <div class="info_social">
                    <a href="">
                        <i class="fa fa-facebook" aria-hidden="true"></i>
                    </a>
                    <a href="">
                        <i class="fa fa-twitter" aria-hidden="true"></i>
                    </a>
                    <a href="">
                        <i class="fa fa-linkedin" aria-hidden="true"></i>
                    </a>
                    <a href="">
                        <i class="fa fa-instagram" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 info_col">
                <div class="info_detail">
                    <h4>
                        Info
                    </h4>
                    <p>
                        necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-2 mx-auto info_col">
                <div class="info_link_box">
                    <h4>
                        Links
                    </h4>
                    <div class="info_links">
                        <a class="active" href="paginaPrincipal.php">
                            Home
                        </a>
                        <a class="" href="about.html">
                            About
                        </a>
                        <a class="" href="cursos.php">
                            Services
                        </a>
                        <a class="" href="why.html">
                            Why Us
                        </a>
                        <a class="" href="team.html">
                            Team
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 info_col ">
                <h4>
                    Subscribe
                </h4>
                <form action="#">
                    <input type="text" placeholder="Enter email" />
                    <button type="submit">
                        Subscribe
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- end info section -->


<!-- jQery -->
<script type="text/javascript" src="jquery-3.4.1.min.js"></script>
<!-- popper js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
</script>
<!-- bootstrap js -->
<script type="text/javascript" src="bootstrap.js"></script>
<!-- owl slider -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
</script>
<!-- custom js -->
<script type="text/javascript" src="custom.js"></script>
<!-- Google Map -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
</script>
<!-- End Google Map -->

</body>

</html>
<?php

mysqli_close($conn);