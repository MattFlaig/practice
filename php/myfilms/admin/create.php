<?php
    require_once '../lib/database.php';

    session_start();

    if (logged_in()){

        $stmt = $db->prepare('SELECT * FROM films');
        $stmt->execute();
        $films = $stmt->fetchAll();
        unset($stmt);

        $stmt = $db->prepare('SELECT * FROM directors');
        $stmt->execute();
        $directors = $stmt->fetchAll();
        unset($stmt);

        $stmt = $db->prepare('SELECT * FROM actors');
        $stmt->execute();
        $actors = $stmt->fetchAll();
        unset($stmt);

        $stmt = $db->prepare('SELECT * FROM categories');
        $stmt->execute();
        $categories = $stmt->fetchAll();
        unset($stmt);


        if($_POST){

            $stmt = $db->prepare('INSERT INTO films (title, release_date, duration, description, director_id)VALUES(:title, :release_date, :duration, :description, :director_id)');

            $stmt->execute(array(':title'=> $_POST['title'],':release_date'=> $_POST['release_date'],':duration'=> $_POST['duration'],':description'=> $_POST['description'],':director_id'=> $_POST['director_id']));
            $last_film = $db->lastInsertId('film_id');
            unset($stmt);

            $actor_ids = $_POST['actor_ids'];

            foreach ($actor_ids as $ac) :
            $stmt = $db->prepare("INSERT INTO actors_films (actor_id, film_id)VALUES($ac, $last_film)");
            endforeach;
            $stmt->execute($_POST['actor_ids']);
            print_r($stmt);
            unset($stmt);

            $category_ids = $_POST['category_ids'];
            foreach ($category_ids as $cat) :
            $stmt = $db->prepare("INSERT INTO categories_films (category_id, film_id)VALUES($cat, $last_film)");
            endforeach;
            $stmt->execute($_POST['category_ids']);
            unset($stmt);

            redirect("/user/films.php");
        }
    }
    else{
    redirect("../index.php");
    }
    
  
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
                <form id="search" action="../user/search.php" method="get">
                    <input type="text" id="search_input" name="search" value="Search for films"/>
                    <input type="submit" id="search_button" value="SEARCH"/>
                </form>
                <li><a href="../index.php" >Home</a></li>
                <li><a href="../user/films.php" >Films</a></li>
                <?php if(logged_in()) : ?>
                    <li><a href="create.php" >New</a></li>
                    <li><a href="logout.php" >Logout</a></li>
                <?php endif; ?>
            </ul>
        </nav>
    </header>

    <!-- Spacer for SVG random colour image -->
    <section id="spacer">
    </section>


    <!-- Main Section -->
    <section id="main">
        <h1>Add a new Film</h1>
        <section id="container">
            <form id="create_film" action="create.php" method="post">
            <table>
                <tr>
                    <td><label>Title</label></td><td><input type="text" name="title" /></td>
                </tr>
                <tr>
                    <td><label>Release Year</label></td><td><input type="text" name="release_date" /></td>
                </tr>
                <tr>
                    <td><label>Duration in minutes</label></td><td><input type="text" name="duration" /></td>
                </tr>
                <tr>
                    <td><label>Description</label></td>
                    <td><textarea name="description"></textarea></td>
                </tr>
                <tr>
                    <td><label>Director</label></td>
                    <td>
                        <select name="director_id">
                            <?php foreach ($directors as $key => $value) : ?>
                                <option value='<?php echo $value["director_id"] ?>'><?php echo $value["director_name"]; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><label>Actors</label></td>
                    <td>
                        <select multiple name="actor_ids[]">
                            <?php foreach ($actors as $key => $value) : ?>
                                <option value='<?php echo $value["actor_id"] ?>'><?php echo $value["actor_name"]; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><label>Categories</label></td>
                    <td>
                        <select multiple name="category_ids[]">
                            <?php foreach ($categories as $key => $value) : ?>
                                <option value='<?php echo $value["category_id"] ?>'><?php echo $value["category_name"]; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </td>
                </tr>
            </table>

            <p>
              <input id="form_button" type="submit" value="Save Film">
            </p>
            </form>
        </section>
    </section>

    
    <!-- Footer with navigation and Copyright -->
    <footer>
        <section class="wrapper">

        <ul>
            <li><a href="../index.php" >Home</a></li>
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