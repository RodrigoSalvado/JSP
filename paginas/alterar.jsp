<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../basedados/basedados.h" %>
<%
    String user = (String) session.getAttribute("username");
    int tipo = session.getAttribute("tipo_utilizador")==null? 0: (Integer) session.getAttribute("tipo_utilizador");

    if(tipo == 1 || tipo == 0){
        out.println("<script>window.alert('Nao tem autorização para entrar aqui') ; window.location.href = 'paginaPrincipal.jsp';</script>");
    }

    boolean alterado = false;

    // Inicialização de variaveis para alteração de dados de um utilizador
    int curso = session.getAttribute("curso")==null? 0: (Integer) session.getAttribute("curso");
    int id_curso = session.getAttribute("id_curso")==null? -1: (Integer) session.getAttribute("id_curso");






    // Inicialização de variaveis para alteração de dados de um utilizador

    int utilizador = session.getAttribute("utilizador")==null? 0: (Integer) session.getAttribute("utilizador");
    int id_utilizador = session.getAttribute("id_utilizador")==null? -1: (Integer) session.getAttribute("id_utilizador");

    String nUsername = request.getParameter("username") == ""? null: request.getParameter("username");
    String nEmail = request.getParameter("email") == ""? null: request.getParameter("email");
    String nPass = request.getParameter("pass") == ""? null: request.getParameter("pass");
    int nTipo_utilizador = request.getParameter("tipo_utilizador") == null? -1: Integer.parseInt(request.getParameter("tipo_utilizador"));

    String username = null;
    String email = null;
    String password = null;
    int tipo_utilizador = 0;


    if(utilizador == 1){

        sql = "SELECT * FROM utilizador WHERE id_utilizador = "+ id_utilizador +";";
        psSql = conn.prepareStatement(sql);
        rsSql = psSql.executeQuery();

        if(rsSql.next()){
            username = rsSql.getString("username");
            email = rsSql.getString("email");
            password = rsSql.getString("password");
            tipo_utilizador = rsSql.getInt("tipo_utilizador");
        }

        if(nUsername != null){
            sql = "SELECT * FROM utilizador WHERE username = '"+nUsername+"'";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            if(rsSql.next()){
                out.println("<script>window.alert('Esse username já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script>");
            }else{
                sql = "UPDATE utilizador SET username = '"+nUsername+"' WHERE id_utilizador = "+id_utilizador+";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                if(user.equals(username)){
                    session.removeAttribute("username");
                    session.setAttribute("username", nTipo_utilizador);
                }

                alterado = true;
            }
        }

        if(username.equals(nEmail)){
            sql = "SELECT * FROM utilizador WHERE email = '"+nEmail+"'";
            psSql = conn.prepareStatement(sql);
            rsSql = psSql.executeQuery();

            if(rsSql.next()){
                out.println("<script>window.alert('Esse email já existe!') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script>");
            }else{
                sql = "UPDATE utilizador SET email = '"+nEmail+"' WHERE id_utilizador = "+id_utilizador+";";
                psSql = conn.prepareStatement(sql);
                psSql.executeUpdate();

                alterado = true;
            }
        }

        if(username.equals(nPass)){
            sql = "UPDATE utilizador SET password = '"+nPass+"' WHERE id_utilizador = "+id_utilizador+";";
            psSql = conn.prepareStatement(sql);
            psSql.executeUpdate();

            alterado = true;
        }



        if(nTipo_utilizador != tipo_utilizador && nTipo_utilizador != -1){
            sql = "UPDATE utilizador SET tipo_utilizador = "+nTipo_utilizador+" WHERE id_utilizador = "+id_utilizador+";";
            psSql = conn.prepareStatement(sql);
            psSql.executeUpdate();

            if(user.equals(username)){
                session.removeAttribute("tipo_utilizador");
                session.setAttribute("tipo_utilizador", nTipo_utilizador);
            }

            alterado = true;
        }

        if(alterado){
            if(tipo == 4 && (!user.equals(username))){
                out.println("<script>window.alert('Dados alterados com sucesso') ; window.location.href = 'gestaoUtilizadores.php';</script>");
            }else{
                out.println("<script>window.alert('Dados alterados com sucesso!') ; window.location.href = 'perfil.jsp';</script>");
            }
        }else{
            out.println("<script>window.alert('Insira algum dado para ser alterado') ; window.location.href = 'gerirDados.php?utilizador=1&id="+id_utilizador+"';</script");
        }

    }


%>

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