<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    // Protecao de pagina/script
    if(tipo == 1 || tipo == 0 || tipo == 2){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    int id_curso = request.getParameter("id_curso") == null? -1: Integer.parseInt(request.getParameter("id_curso"));

    // Dados do curso
    sql = "SELECT * FROM curso WHERE id_curso = "+id_curso+";";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();

    rsSql.next();

    String nome = rsSql.getString("nome");

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

    <title> Finexo </title>

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
                <a class="navbar-brand" href="paginaPrincipal.jsp">
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
                            <a class="nav-link" href="paginaPrincipal.jsp">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.html"> About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cursos.jsp">Cursos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="why.html">Why Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="team.html">Team</a>
                        </li>

                        <%
                            if(user != null){
                                out.println("<li class='nav-item'><a class='nav-link' href='perfil.jsp'>Perfil-"+user+"</a></li>");
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
</div>


<!-- service section -->


<div class="heading_container heading_center" style="margin-top: 80px">
    <h2>
        Inscrição de Utilizadores para o Curso<br> <%=nome%> <span></span>
    </h2>
    <div class="container">
        <table class="table table-primary table-sortable" role="grid">

                <%




                    out.println("<thead>\n" +
"                                <tr>\n" +
"                                    <th class=\"text-center header\" scope=\"col\" role=\"columnheader\"><span>Inscrever</span></th>\n" +
"                                    <th class=\"text-center header\" scope=\"col\" role=\"columnheader\"><span>Utilizador</span></th>\n" +
"                                </tr>\n" +
"                            </thead>\n" +
"                            <tbody>\n" +
"                            <div class=\"botoes_gest\">");

                            // Vê os utilizadores que nao estao inscritos no curso, exclui o docente
                            sql = "SELECT id_utilizador, username FROM utilizador WHERE id_utilizador NOT IN " +
                             "(SELECT uc.id_utilizador FROM util_curso uc WHERE uc.id_curso = "+ id_curso+") AND username NOT IN " +
                              "(SELECT docente FROM curso WHERE id_curso = "+id_curso+");\n";

                            psSql = conn.prepareStatement(sql);
                            rsSql = psSql.executeQuery();
                            %>

                    <form action="inscreverUsers.jsp?id_curso=<%=id_curso%>" method="post">

                            <%
                            // Printar os utilizadores
                            while(rsSql.next()){
                                String username = rsSql.getString("username");
                                int id_utilizador = rsSql.getInt("id_utilizador");

                                out.println("<tr>\n" +
"                                        <td class='text-center'><input type='checkbox' name='utilizadores' value='" + id_utilizador + "'></td>" +
"                                        <td class='text-center'>"+ username +"</td>\n" +
"                                    </tr>");


                            }

                            out.println(" </div>\n" +
"                                        </tbody>\n" +
"                                    </table><br><br>");

                            out.println("<input type=\"submit\" name=\"botao\" value=\"Inscrever Utilizadores\">");
                            %>
                    </form>
<br><br>

    </div>
</div>


<!-- end service section -->

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
                        <a href="https://maps.app.goo.gl/Ws5RFJAZ9N5P5Rpv7">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                            <span>
                  Location
                </span>
                        </a>
                        <a href="">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                            <span>
                  Call (+351) 272 339 301
                </span>
                        </a>
                        <a href="">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                            <span>
                  est@ipcb.pt
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
                        <a class="active" href="paginaPrincipal.jsp">
                            Home
                        </a>
                        <a class="" href="about.html">
                            About
                        </a>
                        <a class="" href="cursos.jsp">
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

<%
    conn.close();
%>