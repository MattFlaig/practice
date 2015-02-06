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
      
    <?php
      require_once 'database.php';

      try {
          $conn = new PDO("mysql:host=$servername;port=$port;dbname=$dbname", $username, $password, $options);
        
          # set UTF8
          $conn->query('SET NAMES utf8');

          # sql statement
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
        
          # prepare and execute statement
          $stmt = $conn->query($sql);
        
        
          # alle Zeilen holen
          $result = $stmt->fetchAll();
      # Anzahl zeilen ausgeben
      }
      catch(PDOException $e){
          echo $sql . "<br>" . $e->getMessage();
      }

      $conn = null;
    ?> 
    

      <h1>Films</h1>
      <table>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Release Year</th>
          <th>Duration</th>
          <th>Description</th>
          <th>Director</th>
          <th>Actors</th>
          <th>Categories</th>
        </tr>
      
      <?php foreach($result as $row) : ?>
          <tr>
            <td><?php echo $row['film_id']; ?> </td>
            <td><?php echo $row['title']; ?> </td>
            <td><?php echo $row['release_date']; ?> </td>
            <td><?php echo $row['duration']; ?> </td>
            <td><?php echo $row['description']; ?> </td>
            <td><?php echo $row['director_name']; ?> </td>
            <td><?php echo $row['actors']; ?> </td>
            <td><?php echo $row['categories']; ?> </td>
          </tr>
      <?php endforeach ?>

      </table>
  
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