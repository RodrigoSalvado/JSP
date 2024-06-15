<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador") == null ? 0 : (Integer) session.getAttribute("tipo_utilizador");

    // Protecao da pagina/script
    if (tipo == 1 || tipo == 0) {
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    // Cer que tipo de dados estamos a tratar
    int utilizador = request.getParameter("utilizador") == null ? 0 : 1;
    int curso = request.getParameter("curso") == null ? 0 : 1;

    // Vai buscar os id's
    int utilizadorAlterar = request.getParameter("id_utilizador") == null ? 0 : Integer.parseInt(request.getParameter("id_utilizador"));
    int cursoAlterar = request.getParameter("id_curso") == null ? 0 : Integer.parseInt(request.getParameter("id_curso"));

    // Inicializacao de variaveis relativas ao utilizador
    String username = null;
    String email = null;
    String password = null;
    int tipo_utilizador = 0;
    String cargo=null;

    // Inicializacao de variaveis relativas ao curso
    String nome = null;
    String descricao = null;
    String docente = null;
    int max_num = 0;
    int inscritos = 0;


    if (utilizador == 1) {
        // Vai buscar os dados do utilizador
        sql = "SELECT * FROM utilizador WHERE id_utilizador = '" + utilizadorAlterar + "'";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        rsSql.next();

        username = rsSql.getString("username");
        email = rsSql.getString("email");
        password = rsSql.getString("password");
        tipo_utilizador = rsSql.getInt("tipo_utilizador");

        switch(tipo_utilizador){
            case 1:
                cargo = "Cliente";
                break;
            case 2:
                cargo= "Aluno";
                break;
            case 3:
                cargo= "Docente";
                break;
            case 4:
                cargo= "Administrador";
                break;
            case 5:
                cargo = "Apagado";
                break;
            default:
                cargo= "Desconhecido";
                break;
        }
    }



    if (curso == 1) {
        // Vai buscar os dados do curso
        sql = "SELECT * FROM curso WHERE id_curso = '" + cursoAlterar + "'";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        rsSql.next();

        nome = rsSql.getString("nome");
        docente = rsSql.getString("docente");
        descricao = rsSql.getString("descricao");
        max_num = rsSql.getInt("max_num");

        sql = "SELECT COUNT(*) as inscritos FROM util_curso WHERE id_curso = '" + cursoAlterar + "' AND aceite = 1";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();
        rsSql.next();

        inscritos = rsSql.getInt("inscritos");
    }


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
                            if (user != null) {
                                out.println("<li class='nav-item'><a class='nav-link' href='perfil.jsp'>Perfil-" + user + "</a></li>");
                            }
                        %>

                        <li class="nav-item">
                            <%
                                if (user != null) {
                                    out.println("<a class='nav-link' href='logout.jsp'><i class='fa fa-user' aria-hidden='true'></i> Logout</a>");
                                } else {
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

<!-- alterar dados -->

<%

if(utilizador == 1){

    // Vai buscar os cargos disponiveis
    sql = "SELECT * FROM tipo_utilizador";
    psSql = conn.prepareStatement(sql);
    rsSql = psSql.executeQuery();



    out.println("<div class=\"container-inscricao\">\n" +
            "            <div class=\"informacoes\">\n" +
            "                <form action=\"alterar.jsp?utilizador=" + utilizador + "&id_utilizador="+utilizadorAlterar+"\" method=\"post\" >\n" +
            "                    <br>\n" +
            "                    <h3>Alterar informações pessoais</h3>\n" +
            "                    <br><br>\n" +
            "                    <label>Username:  " + username + " </label>\n" +
            "                    <br>\n" +
            "                    <input type=\"text\" name=\"username\" placeholder=\"Novo username\" class=\"inp\">\n" +
            "                    <br><br>\n" +
            "                    <label>Email: " + email + "</label>\n" +
            "                    <br>\n" +
            "                    <input type=\"email\" name=\"email\" placeholder=\"Novo email\"  class=\"inp\">\n");

            // vê se é o admin e faz a logica do select para os cargos
            if(tipo == 4){

                // Definir um cargo para o utilizador
                out.println("    <br><br>\n" +
                            "    <label>Tipo Utilizador: " + cargo + "</label>\n" +
                            "    <br>\n" +
                            "    <select name=\"tipo_utilizador\" class=\"inp\">" +
                            "    <option></option>"); // Opcao em braco para nao haver um valor pré-definido

                while(rsSql.next()){
                    if(rsSql.getInt("id") != tipo_utilizador && rsSql.getInt("id") != 5){ // Exclui o cargo atual do utilizador e APAGADO
                        out.println("<option value=\""+rsSql.getInt("id")+"\">"+rsSql.getString("cargo")+"</option>");
                    }
                }
                out.println("</select>");


                // Os "Clientes" e "Apagados" nao podem inscrever-se em cursos
                if(tipo_utilizador != 1 && tipo_utilizador != 5){
                    // Vê em que cursos o utilizador não tem nenhuma inscrição
                    sql = "SELECT c.nome, c.id_curso FROM curso c WHERE c.id_curso NOT IN" +
                            " (SELECT uc.id_curso FROM util_curso uc WHERE uc.id_utilizador = "+utilizadorAlterar+") AND " +
                            " docente != (SELECT username FROM utilizador WHERE id_utilizador = "+utilizadorAlterar+");";

                    psSql = conn.prepareStatement(sql);
                    rsSql = psSql.executeQuery();

                    out.println("<br><br>\n" +
                            "<label>Cursos em que não está inscrito: </label>\n" +
                            "<br>\n");

                    while (rsSql.next()) {
                        String nomeCurso = rsSql.getString("nome");
                        int id_curso = rsSql.getInt("id_curso");
                        out.println("<label><input type='checkbox' name='cursos' value='" + id_curso + "'> " + nomeCurso + "</label><br>");
                    }
                }


            }

    out.println(
            "                    <br><br>\n" +
            "                    <label>Password: " + password + " </label>\n" +
            "                    <br>\n" +
            "                    <input type=\"text\" name=\"pass\" placeholder=\"Nova password\"   class=\"inp\">\n" +
            "                    <br><br><br>\n" +
            "                    <input type=\"submit\" value=\"Alterar dados\" name=\"botao\" class=\"inp\">\n" +
            "                    <br><br>\n" +
            "                </form>\n" +
            "            </div>\n" +
            "        </div>");

}

if(curso == 1){

    // Admin
    if(tipo == 4){
        // Vê os utilizadores que podem ser docentes
        sql = "SELECT * FROM utilizador WHERE tipo_utilizador = 3 OR tipo_utilizador = 4";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        out.println("<div class=\"container-inscricao\">\n" +
                "    <div class=\"informacoes\">\n" +
                "        <form action=\"alterar.jsp?curso=1&id_curso="+cursoAlterar+"\" method=\"post\" >\n" +
                "            <br>\n" +
                "            <h3>Alterar Informações do Curso</h3>\n" +
                "            <br><br>\n" +
                "            <label>Nome: "+ nome +"</label>\n" +
                "            <br>\n" +
                "            <input type=\"text\" name=\"nome\" placeholder=\"Nome do curso...\" class=\"inp\">\n" +
                "            <br><br>\n" +
                "            <label>Docente: "+ docente +"</label>\n" +
                "            <br>\n");

        // Selecao de um docente
        out.println(
                "            <select name=\"docente\" class=\"inp\">" +
                        "        <option></option>"); // Valor em branco

        while(rsSql.next()){
            if(!rsSql.getString("username").equals(docente)){ // Vê os possiveis docentes diferentes do atual
                out.println("<option value=\""+rsSql.getString("username")+"\">"+rsSql.getString("username")+"</option>");
            }
        }
        out.println("</select>");

        out.println("        <br><br>\n" +
                "            <label>Descrição do Curso:</label>\n" +
                "            <br>\n" +
                "            <textarea type=\"text\" name=\"descricao\" placeholder=\"Descrição do curso...\" class=\"inp\"></textarea>\n" +
                "            <br><br>\n" +
                "            <label>Numero vagas disponiveis: "+ (max_num - inscritos) +"</label><br>\n" +
                "            <label>Numero inscritos: "+ inscritos +"</label>\n" +
                "            <br>\n" +
                "            <input type=\"number\" min=\""+ inscritos +"\" step=\"1\" name=\"max_num\" placeholder=\"Insira número de vagas...\"  class=\"inp\" \n");

                // Vê os alunos inscritos no curso
                sql = "SELECT u.username, u.id_utilizador FROM utilizador u JOIN util_curso uc ON u.id_utilizador = uc.id_utilizador WHERE uc.id_curso = "+cursoAlterar+" AND uc.aceite = 1;";
                psSql = conn.prepareStatement(sql);
                rsSql = psSql.executeQuery();

                out.println("<br><br><br>\n" +
                        "<label>Utilizadores Inscritos: </label><br>\n" +
                        "<label>(Selecione para Expulsar do Curso): </label>\n" +
                        "<br>\n");

                while (rsSql.next()) {
                    String insUser = rsSql.getString("username");
                    int id_utilizador = rsSql.getInt("id_utilizador");
                    out.println("<label><input type='checkbox' name='utilizadores' value='" + id_utilizador + "'> " + insUser + "</label><br>");
                }

        out.println("            <br><br>\n" +
                "            <input type=\"submit\" value=\"Alterar Curso\" name=\"botao\">\n" +
                "            <br><br>\n" +
                "        </form>\n" +
                "    </div>\n" +
                "</div>");
    }

    // Docente
    if(tipo == 3){
        out.println("<div class=\"container-inscricao\">\n" +
                "    <div class=\"informacoes\">\n" +
                "        <form action=\"alterar.jsp?curso=1&id_curso="+cursoAlterar+"\" method=\"post\" >\n" +
                "            <br>\n" +
                "            <h3>Alterar Informações do Curso</h3>\n" +
                "            <br><br>\n" +
                "            <label>Nome: "+ nome +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Docente: "+ docente +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Descrição do Curso: "+ descricao +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Numero vagas disponiveis: "+ (max_num - inscritos) +"</label><br>\n" +
                "            <label>Numero inscritos: "+ inscritos +"</label>\n" +
                "            <br>\n" +
                "            <input type=\"number\" min=\""+ inscritos +"\" step=\"1\" name=\"max_num\" placeholder=\"Insira número de vagas...\"  class=\"inp\">\n");

                        // Vê os utilizadores inscritos no curso
                        sql = "SELECT u.username, u.id_utilizador FROM utilizador u JOIN util_curso uc ON u.id_utilizador = uc.id_utilizador WHERE uc.id_curso = "+cursoAlterar+";";
                        psSql = conn.prepareStatement(sql);
                        rsSql = psSql.executeQuery();

                        out.println("<br><br><br>\n" +
                                "<label>Utilizadores Inscritos: </label><br>\n" +
                                "<label>(Selecione para Expulsar do Curso): </label>\n" +
                                "<br>\n");

                        while (rsSql.next()) {
                            String insUser = rsSql.getString("username");
                            int id_utilizador = rsSql.getInt("id_utilizador");
                            out.println("<label><input type='checkbox' name='utilizadores' value='" + id_utilizador + "'> " + insUser + "</label><br>");
                        }

        out.println("        <br><br>\n" +
                "            <input type=\"submit\" value=\"Alterar Curso\" name=\"botao\">\n" +
                "            <br><br>\n" +
                "        </form>\n" +
                "    </div>\n" +
                "</div>");
    }

    // Aluno

    if(tipo == 2){
        // Vê as informacoes do curso
        out.println("<div class=\"container-inscricao\">\n" +
                "    <div class=\"informacoes\">\n"+
                "            <br>\n" +
                "            <h3>Informações do Curso</h3>\n" +
                "            <br><br>\n" +
                "            <label>Nome: "+ nome +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Docente: "+ docente +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Descrição do Curso: "+ descricao +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "            <label>Numero vagas disponiveis: "+ (max_num - inscritos) +"</label><br>\n" +
                "            <label>Numero inscritos: "+ inscritos +"</label>\n" +
                "            <br>\n" +
                "            <br><br>\n" +
                "    </div>\n" +
                "</div>");
    }


}



%>











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