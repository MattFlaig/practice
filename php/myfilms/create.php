<?php
  require_once 'database.php';

  if($_POST){
    $db = new PDO("mysql:host=$servername;port=$port;dbname=$dbname", $username, $password, $options);
    $db->query('SET NAMES utf8');
    $radio = $db->query('SELECT directors.director_id, directors.director_name FROM directors');  
    $radio_results = $radio->fetchAll;

    $stmt = $db->prepare('INSERT INTO films (title, release_date, duration, description, director_id)VALUES(:title, :release_date, :duration, :description, :director_id)');
    $stmt->execute($_POST);

    redirect('read.php');
  }
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
          <li><a href="index.html" >Home</a></li>
          <li><a href="films.php" >Films</a></li>
          <li><a href="admin.html">Admin</a></li>
        </ul>
      </nav>
    </header>

    <!-- Spacer for SVG random colour image -->
    <section id="spacer">
    </section>


    <!-- Main Section -->
    <section id="main">
      <h1>Add a new Film</h1>
      <form action="<?php echo $ SERVER['PHP SELF'] ?>" method="post">
        <p>
          <label>Title</label>
          <input type="text" name="title" />
        </p>
        <p>
          <label>Release Year</label>
          <input type="text" name="release_date" />
        </p>
        <p>
          <label>Duration in minutes</label>
          <input type="text" name="duration" />
        </p>
        <p>
          <label>Description</label>
          <input type="text" name="description" />
        </p>
        <p>Director
          <?php
            foreach($radioResults as $key => $value){
              echo '<label>' . $value['director_name'] . '</label>';
              echo '<input type="radio" name="director_id" value="' . $value['director_id'] . '">';
            }
          ?>
          <br>
        </p>
        <p>
          <input type="submit" value="Save">
        </p>
      </form>
    </section>

    
    <!-- Footer with navigation and Copyright -->
    <footer>
      <section class="wrapper">
        
        <ul>
          <li><a href="index.html" >Home</a></li>
          <li><a href="films.php" >Films</a></li>
          <li><a href="admin.html">Admin</a></li>
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