<?php
    require_once '../lib/database.php';
    session_start();

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
                <form id="search" action=' <?php echo htmlspecialchars("search.php");?>' method="get">
                    <input type="text" id="search_input" name="search" value="Search for films"/>
                    <input type="submit" id="search_button" value="SEARCH"/>
                </form>
                <li><a href="../index.php" >Home</a></li>
                <li><a href="films.php" >Films</a></li>
                <?php if(logged_in()) : ?>
                    <li><a href="../admin/create.php" >New</a></li>
                    <li><a href="../admin/logout.php?logout=true" >Logout</a></li>
                <?php endif; ?>
            </ul>
        </nav>
    </header>

    <!-- Spacer for SVG random colour image -->
    <section id="spacer">
    </section>


    <!-- Main Section -->
    <section id="main">
        <h1>Impressum</h1>
        <section id="container">
        
        <table>
        <tr><th>    MyFilms GmbH</th><tr>
        <tr>
            <td>
            Filmstraße 169</br>
            98765 Starau bei Redcarpetingen</br>
            info@myfilms.com</br>
            </td>
        </tr>
        </p>
        <tr>
            <td>
            Geschäftsführer: Myfilmo Myfilmerich, Holly Woody</br>
            Handelsregister: FIL 19691 HW</br>
            Registergericht: Amtsgericht Redcarpetingen</br>
            USt-ID: DE1166996611</br>
            </td>
        </tr>
        </table>
        </section>
    </section>

    
    <!-- Footer with navigation and Copyright -->
    <footer>
        <section class="wrapper">
        
        <ul>
            <li><a href="../index.php" >Home</a></li>
            <li><a href="films.php" >Films</a></li>
            <li><a href="impressum.php" >Impressum</a></li>
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