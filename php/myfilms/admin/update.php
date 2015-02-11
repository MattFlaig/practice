<?php
    require_once '../lib/database.php';
    session_start();

    if (logged_in()){

        empty($_REQUEST['film_id']) && render404();
        
        $stmt = $db->prepare('SELECT * FROM films WHERE film_id = ? LIMIT 1');
        $stmt->execute(array($_REQUEST['film_id']));
        $film = $stmt->fetch();
        unset($stmt);

        $stmt = $db->prepare('SELECT * FROM directors');
        $stmt->execute();
        $directors = $stmt->fetchAll();
        unset($stmt);


        if($_POST){
            print_r($_POST);

            $stmt = $db->prepare('UPDATE films SET film_id=:film_id, title=:title, release_date=:release_date, duration=:duration, description=:description, director_id=:director_id WHERE film_id=:film_id');
            $stmt->execute(array(':film_id' => $_POST['film_id'], ':title'=> $_POST['title'],':release_date'=> $_POST['release_date'],':duration'=> $_POST['duration'],':description'=> $_POST['description'],':director_id'=> $_POST['director_id']));
            unset($stmt);
            redirect('../user/films.php');
        }


    // $stmt = $db->prepare('SELECT * FROM actors');
    // $stmt->execute();
    // $all_actors = $stmt->fetchAll();
    // unset($stmt);

    // $stmt = $db->prepare('SELECT * FROM actors, actors_films WHERE film_id = ? AND actors_films.actor_id = actors.actor_id');
    // $stmt->execute(array($film['film_id']));
    // $selected_actors = $stmt->fetchAll();
    // unset($stmt);

    // $stmt = $db->prepare('SELECT * FROM categories');
    // $stmt->execute();
    // $all_categories = $stmt->fetchAll();
    // unset($stmt);

    // $stmt = $db->prepare('SELECT * FROM categories, categories_films WHERE film_id = ? AND categories_films.category_id = categories.category_id');
    // $stmt->execute(array($film['film_id']));
    // $selected_categories = $stmt->fetchAll();
    // unset($stmt);


    // $actor_ids = $_POST['actor_ids'];
    // foreach ($actor_ids as $ac) :
    //   $stmt = $db->prepare("DELETE FROM actors_films WHERE film_id = ? AND actor_id = $ac");
    // endforeach;
    // $stmt->execute(array($_REQUEST['film_id']));
    // unset($stmt);

    
    // print_r(explode($actor_ids));
    // print_r($selected_actors);
    
    // foreach ($actor_ids as $ac) :
    //   $stmt = $db->prepare("INSERT INTO actors_films (actor_id, film_id)VALUES($ac, film_id)");
    // endforeach;
    // $stmt->execute($_POST['actor_ids']);
    // print_r($stmt);
    // unset($stmt);


    // $category_ids = $_POST['category_ids'];
    // foreach ($category_ids as $cat) :
    //   $stmt = $db->prepare("DELETE FROM categories_films WHERE film_id = ? AND category_id = $cat");
    // endforeach;
    // $stmt->execute(array($_REQUEST['film_id']));
    // unset($stmt);

    
    // foreach ($category_ids as $cat) :
    //   $stmt = $db->prepare("INSERT INTO categories_films (category_id, film_id)VALUES($cat, film_id)");
    // endforeach;
    // $stmt->execute($_POST['category_ids']);
    // unset($stmt);

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
        <h1>Edit Film: "<?php echo $film['title'] ?>"</h1>

        <section id="container">
            <form id="create_film" action="update.php" method="post">
            <input type="hidden" name="film_id" value="<?php echo $film['film_id'] ?>" />

            <table>
            <tr>
                <td><label>Title</label></td><td><input type="text" name="title" value="<?php echo $film['title'] ?>" /></td>
            </tr>
            <tr>
                <td><label>Release Year</label></td><td><input type="text" name="release_date" value="<?php echo $film['release_date'] ?>"/></td>
            </tr>
            <tr>
                <td><label>Duration in minutes</label></td><td><input type="text" name="duration" value="<?php echo $film['duration'] ?>"/></td>
            </tr>
            <tr>
                <td><label>Description</label></td>
                <td><textarea name="description"><?php echo $film['description'] ?></textarea></td>
            </tr>
            <tr>
                <td><label>Director</label></td>
                <td>
                    <select name="director_id" >
                        <?php foreach ($directors as $d) : ?>   
                            <option value='<?php echo $d["director_id"] ?>' <?php if($film['director_id'] == $d['director_id']) {echo "selected";}?> > <?php echo $d["director_name"]; ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
            </tr>

           <!--  <tr>
            <p>
              <td><label>Actors</label></td>
              <td>
                <select multiple name="actor_ids[]">
                    <?php// foreach ($all_actors as $all) : ?>
                      <option value='<?php// echo $all["actor_id"] ?>' 
                        <?php// foreach ($selected_actors as $selected){if($selected['actor_id'] == $all['actor_id']) {echo "selected";}}?> >
                        <?php// echo $all["actor_name"]; ?>
                      </option>
                    <?php// endforeach; ?>
                </select>
              </td>
            </p>
            </tr>

            <tr>
              <p>
                <td><label>Categories</label></td>
                <td>
                  <select multiple name="category_ids[]">
                    <?php// foreach ($all_categories as $all) : ?>
                        <option value='<?php// echo $all["category_id"] ?>'
                          <?php// foreach ($selected_categories as $selected){if($selected['category_id'] == $all['category_id']) {echo "selected";}} ?> >
                          <?php// echo $all["category_name"]; ?>
                        </option>
                    <?php// endforeach; ?>
                  </select>
                </td>
              </p>
            </tr> -->
            </table>

            <p>
                <input id="form_button" type="submit" value="Update Film">
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