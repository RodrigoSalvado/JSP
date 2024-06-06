<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="static java.sql.JDBCType.NULL" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%

String user = (String) session.getAttribute("username");
int tipo = (Integer) session.getAttribute("tipo_utilizador");

out.println(user);
%>

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

<body>

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

                <%
                if(user != null){
                    out.println("<li class='nav-item'><a class='nav-link' href='perfil.php'>Perfil-"+user+"</a></li>");
                }
                %>

              <li class="nav-item">
                <%
                  if(user != null){
                    out.println("<a class='nav-link' href='logout.jsp'><i class='fa fa-user' aria-hidden='true'></i> Logout</a>");
                  }else{
                    out.println("<a class='nav-link' href='login.html'><i class='fa fa-user' aria-hidden='true'></i> Login</a>");
                  }
                %>
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
    <!-- slider section -->
    <section class="slider_section ">
    <div id="customCarousel1" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="container ">
            <div class="row">
              <div class="col-md-6 ">
                <div class="detail-box">
                  <h1>
                    Bem Vindo à <br>
                    Crypto Academy <ion-icon name="logo-bitcoin"></ion-icon>
                  </h1>
                  <p>
                    Na Crypto Academy a nossa missão é ajuda-lo a adquirir o conhecimento e as habilidades necessárias para entrar com confiança no mundo dos investimentos e das criptomoedas. Oferecemos uma variedade de cursos que abrangem diversas áreas e diferentes estratégias.
                    <br>Registe-se no nosso site e venha aprender connosco!
                  </p>
                  <div class="btn-box">

                      <?php
                        if(empty($_SESSION["user"])){
                            echo '<a href="login.html" class="btn1">
                      Registe-se!
                    </a>';
                        }
                      ?>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="img-box">
                  <img src="slider-img.png" alt="">
                </div>
              </div>
            </div>
          </div>
        </div>


    </div>

  </section>
    <!-- end slider section -->
  </div>


  <!-- service section -->

  <section class="service_section layout_padding">
    <div class="service_container">
      <div class="container ">
        <div class="heading_container heading_center">
          <h2>
            Os nossos <span>Cursos</span>
          </h2>
          <p>
          </p>
        </div>

          <?php
            $sql = "SELECT *, COUNT(*) as total FROM curso";
            $result = mysqli_query($conn, $sql);
            $count = 0;

            if(mysqli_num_rows($result)>0) {
                $row = mysqli_fetch_assoc($result);

                for ($i = 3; $i < $row["total"] + 3; $i++) {
                    if ($i % 3 == 0) {
                        echo '<div class="row">';
                    }
                    $curso = $cursos[$count];
                    echo printCursos($curso, ($i%3)+1, isset($_SESSION["user"]));
                    if ($i % 3 == 2) {
                        echo '</div>';
                    }
                    $count++;
                }


            }
                  ?>
              </div>
            </div>
          </div>

      </div>
    </div>
  </section>

  <!-- end service section -->


  <!-- about section -->

  <section class="about_section layout_padding">
    <div class="container  ">
      <div class="heading_container heading_center">
        <h2>
          Bem <span>Vindo!</span>
        </h2>
        <p>
          Venha conhecer os nossos cursos!
        </p>
      </div>
      <div class="row">
        <div class="col-md-6 ">
          <div class="img-box">
            <img src="about-img.png" alt="">
          </div>
        </div>
        <div class="col-md-6">
          <div class="detail-box">
            <h3>
              Crypto Academy
            </h3>
            <p>
                Bem-vindo à Crypto Academy, o seu destino definitivo para cursos especializados em criptomoedas e investimentos! Aqui, encontrará uma vasta gama de conteúdos educativos, desenhados tanto para iniciantes como para investidores experientes, com foco em criptomoedas, ações e ETFs.
            </p>
            <p>

            </p>

          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- end about section -->







  <!-- end client section -->


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
              <a class="active" href="paginaPrincipal.html">
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

  <!-- footer section -->
  <section class="footer_section">
    <div class="container">
      <p>
        &copy; <span id="displayYear"></span> All Rights Reserved By
        <a href="https://html.design/">Free Html Templates</a>
      </p>
    </div>
  </section>
  <!-- footer section -->

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



  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>

</html>
<%


%>



<%
  conn.close();
%>