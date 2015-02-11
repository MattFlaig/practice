<?php
    require_once 'lib/database.php';
    session_start();


?>


<!DOCTYPE html>
<html>
    <head>
        <title>MyFilms</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/myfilm.css" type="text/css" media="screen" />
    </head>

    <body>

  <!-- Header with navigation -->
        <header>
            <h1>MyFilms</h1>
            <nav>
                <ul>
                    <form id="search" action="user/search.php" method="get">
                        <input type="text" id="search_input" name="search" value="Search for films"/>
                        <input type="submit" id="search_button" value="SEARCH"/>
                    </form>
                    <li><a href="index.php" >Home</a></li>
                    <li><a href="user/films.php" >Films</a></li>
                    <?php if(logged_in()) : ?>
                        <li><a href="admin/create.php" >New</a></li>
                        <li><a href="admin/logout.php" >Logout</a></li>
                    <?php endif; ?>
                </ul>
            </nav>
        </header>

        <!-- Spacer for SVG random colour image -->
        <section id="spacer">
        </section>


        <!-- Main Section -->
        <section id="main">
            <?php if(logged_in()) : ?>
                <h1>Welcome admin! Have fun with the CRUD stuff!</h1>
                <section id="container">
                    <table>
                        <tr>
                            <td>
                                <a href="admin/create.php" >New Film</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="admin/create_names.php" >New Director, Actor, Category</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="user/films.php" >All Films</a>
                            </td>
                        </tr>

                    </table>

                </section>
            <?php else : ?>
                <h1>Welcome to MyFilms, your personal film database. Please feel free to explore!</h1>
            <?php endif; ?>
        </section>

        
        <!-- Footer with navigation and Copyright -->
        <footer>
            <section class="wrapper">
                <ul>
                    <li><a href="index.php" >Home</a></li>
                    <li><a href="user/films.php" >Films</a></li>
                    <li><a href="user/impressum.php" >Impressum</a></li>
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