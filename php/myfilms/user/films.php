<?php
    require_once '../lib/database.php';

    session_start();

    try {
        $sql = "SELECT *, director_name,
            GROUP_CONCAT(DISTINCT actor_name ORDER BY actor_name) AS actors, 
            GROUP_CONCAT(DISTINCT category_name ORDER BY category_name) AS categories 
            FROM films f, directors d, actors_films af, actors a, categories_films cf, categories c 
            WHERE f.director_id = d.director_id
            AND f.film_id = af.film_id 
            AND a.actor_id = af.actor_id
            AND f.film_id = cf.film_id 
            AND c.category_id = cf.category_id
            GROUP BY f.film_id";

        $stmt = $db->query($sql);
        $result = $stmt->fetchAll();
    }
    catch(PDOException $e){
        echo $sql . "<br>" . $e->getMessage();
    }

    $db = null;
?>





<!DOCTYPE html>
<html>
    <head>
        <title>MyFilms</title>
        <meta charset="utf-8">

        <link rel="stylesheet" href="../css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="../css/myfilm.css" type="text/css" media="screen" />
    </head>

    <body>

  <!-- Header with navigation -->
        <header>
            <h1>MyFilms</h1>
            <nav>
                <ul>
                    <form id="search" action="search.php" method="get">
                        <input type="text" id="search_input" name="search" value="Search for films"/>
                        <input type="submit" id="search_button" value="SEARCH"/>
                    </form>
                    <li><a href="../index.php" >Home</a></li>
                    <li><a href="films.php" >Films</a></li>
                    <?php if(logged_in()) : ?>
                        <li><a href="../admin/create.php" >New</a></li>
                        <li><a href="../admin/logout.php" >Logout</a></li>
                    <?php endif; ?>
                </ul>
            </nav>
        </header>

        <!-- Spacer for SVG random colour image -->
        <section id="spacer">
        </section>


        <!-- Main Section -->

        <section id="main">
          
            <h1>Films</h1>

            <section id="container">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Release Year</th>
                        <th>Director</th>
                        <th>Actors</th>
                    </tr>
              
                <?php foreach($result as $row) : ?>
                    <tr>
                        <td><?php echo $row['film_id']; ?> </td>
                        <td><a href="read.php?film_id=<?php echo $row['film_id'] ?>"><?php echo $row['title']; ?></td>
                        <td><?php echo $row['release_date']; ?> </td>
                        <td><?php echo $row['director_name']; ?> </td>
                        <td><?php echo $row['actors']; ?> </td>
                    </tr>
                <?php endforeach ?>
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