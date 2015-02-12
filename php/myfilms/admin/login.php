<?php
    require_once '../lib/database.php';

    if ($_POST){
        session_start();

        $username = $_POST["username"];
        $password = $_POST["password"];

        #put admin in the session
        if ($username == "admin" && $password == "admin"){
            $_SESSION["admin"] = true;
            redirect("../index.php");
        }
        
    }

?>

<!DOCTYPE html>
<html>
    <head>
        <title>MyFilms</title>
        <meta charset="utf-8">
        
        <link rel="stylesheet" href="../css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="../css/myfilm.css" type="text/css" media="screen" />

        <script src="../js/jquery.min.js"></script>
        <script src="../js/spacer.js"></script>

    </head>

    <body>

  <!-- Header with navigation -->
        <header>
            <h1>MyFilms</h1>
            <nav>
                <ul>
                    <form id="search" action=' <?php echo htmlspecialchars("../user/search.php");?>' method="get">
                        <input type="text" id="search_input" name="search" value="Search for films"/>
                        <input type="submit" id="search_button" value="SEARCH"/>
                    </form>
                    <li><a href="../index.php" >Home</a></li>
                    <li><a href="../user/films.php" >Films</a></li>
                    <?php if(logged_in()) : ?>
                        <li><a href="create.php" >New</a></li>
                        <li><a href="logout.php?logout=true" >Logout</a></li>
                    <?php endif; ?>
                </ul>
            </nav>
        </header>

        <!-- Spacer for SVG random colour image -->
        <section id="spacer">
        </section>

        



        <!-- Main Section -->
        <section id="main">
            <section id ="message">
            </section>

            <h1>Login</h1>
            <section id="container">
                <form action=' <?php echo htmlspecialchars("login.php");?>' method="post">
                    
                    <table>
                        <tr>
                            <td><label>Username:</label></td><td> <input type="text" name="username" /></td><br />
                        </tr>
                        <tr>
                            <td><label>Password:</label></td><td> <input type="password" name="password" /></td><br />
                        </tr>
                    </table>
                    <p>
                        <input id="form_button" type="submit" value="Login" />
                    </p>
                </form>
            </section>

        </section>

        
        <!-- Footer with navigation and Copyright -->
        <footer>
            <section class="wrapper">
            
            <ul>
                <li><a href="../user/index.php" >Home</a></li>
                <li><a href="../user/films.php" >Films</a></li>
                <li><a href="../user/impressum.php" >Impressum</a></li>
            </ul>
            
            </section>

            <section id="copyright">
                <div class="wrapper">
                    &copy; Copyright 2015 by Matthias. All Rights Reserved.
                </div>
            </section>
        </footer>
    
    <body>
</html>