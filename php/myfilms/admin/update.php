<?php
    require_once '../lib/database.php';
    session_start();

    if (logged_in()){

        empty($_REQUEST['film_id']) && render404();
        


        #fetching records from db to display in form
        $stmt = $db->prepare('SELECT * FROM films WHERE film_id = ? LIMIT 1');
        $stmt->execute(array($_REQUEST['film_id']));
        $film = $stmt->fetch();
        unset($stmt);

        $stmt = $db->prepare('SELECT * FROM directors');
        $stmt->execute();
        $directors = $stmt->fetchAll();
        unset($stmt);



        #checking if input is there and process the form
         if( (isset($_POST['title']) && !empty($_POST['title']) && ctype_alnum($_POST['title']))
            && (isset($_POST['release_date']) && !empty($_POST['release_date']) && is_numeric($_POST['release_date']))
            && (isset($_POST['duration']) && !empty($_POST['duration']) && is_numeric($_POST['duration']))
            && (isset($_POST['description']) && !empty($_POST['description']) && ctype_alnum($_POST["description"]))
            && (isset($_POST['director_id']) && !empty($_POST['director_id']))
        ){

            $stmt = $db->prepare('UPDATE films SET film_id=:film_id, title=:title, release_date=:release_date, duration=:duration, description=:description, director_id=:director_id WHERE film_id=:film_id');
            $stmt->execute(array(':film_id' => $_POST['film_id'], ':title'=> $_POST['title'],':release_date'=> $_POST['release_date'],':duration'=> $_POST['duration'],':description'=> $_POST['description'],':director_id'=> $_POST['director_id']));
            unset($stmt);
            redirect('../user/films.php');
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
        <h1>Edit Film: "<?php echo $film['title'] ?>"</h1>

        <section id="container">
            <form id="create_film" action=' <?php echo htmlspecialchars("update.php");?>' method="post">
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