<?php
    require_once '../lib/database.php';

    session_start();

    empty($_REQUEST['film_id']) && render404();

    #selct films and directors
    $stmt = $db->prepare("SELECT * FROM films, directors WHERE film_id = ? AND films.director_id = directors.director_id");
    $stmt->execute(array($_REQUEST['film_id']));
    $film = $stmt->fetch();
    unset($stmt);

    $film || render404();

    #select actors and respective join table
    $stmt = $db->prepare("SELECT actor_name FROM actors_films, actors WHERE film_id = ? AND actors_films.actor_id = actors.actor_id");
    $stmt->execute(array($film['film_id']));
    $actors = $stmt->fetchAll();
    unset($stmt);

    $film || render404();

    #select categories and respective join table
    $stmt = $db->prepare("SELECT category_name FROM categories_films, categories WHERE film_id = ? AND categories_films.category_id = categories.category_id");
    $stmt->execute(array($film['film_id']));
    $categories = $stmt->fetchAll();
    unset($stmt);
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
    
    <h1>Film Details</h1>
      
    <section id="container">
        <table id="search_result">
            <tr>
                <td>ID</td><td><?php echo $film['film_id']; ?> </td>
            </tr>
            <tr>
                <td>Title</td><td><?php echo $film['title']; ?> </td>
            </tr>
            <tr>
                <td>Release Year</td><td><?php echo $film['release_date']; ?> </td>
            </tr>
            <tr>
                <td>Duration</td><td><?php echo $film['duration']; ?> </td>
            </tr>
            <tr>
                <td>Description</td><td><?php echo $film['description']; ?> </td>
            </tr>
            <tr>
                <td>Director</td><td><?php echo $film['director_name']; ?> </td>
            </tr>
            <tr>
                <td>Actors</td>
                <td>
                    <ul>
                        <?php foreach ($actors as $a) : ?>
                            <li>
                                <?php echo $a['actor_name']; ?>
                            </li>
                        <?php endforeach; ?> 
                    </ul>
                </td>
            </tr>
            <tr>
                <td>Categories</td>
                <td>
                    <ul>
                        <?php foreach ($categories as $c) : ?>
                            <li>
                                <?php echo $c['category_name']; ?>
                            </li>
                        <?php endforeach; ?> 
                    </ul>
                </td>
            </tr>
            <?php if(logged_in()) : ?> 
                <tr>
                    <td>Actions</td>
                    <td>
                        <a href="../admin/update.php?film_id=<?php echo $film['film_id'] ?>">Edit</a>
                        <a href="../admin/delete.php?film_id=<?php echo $film['film_id'] ?>">Delete</a>
                    </td>
                </tr>
            <?php endif; ?>
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