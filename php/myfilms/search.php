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
          <form id="search" action="search.php" method="get">
            <input type="text" id="search_input" name="search" value="Search for films"/>
            <input type="submit" id="search_button" value="SEARCH"/>
          </form>
          <li><a href="index.html" >Home</a></li>
          <li><a href="films.php" >Films</a></li>
          <li><a href="impressum.html" >Impressum</a></li>
          <li><a href="admin.html">Admin</a></li>
        </ul>
      </nav>
    </header>

    <!-- Spacer for SVG random colour image -->
    <section id="spacer">
    </section>


    <!-- Main Section -->
    <section id="main">
      <h1>Search Results</h1>
      <?php
        if(isset($_GET['search'])){
          if(preg_match("/[A-Za-z0-9]+/", $_GET['search'])){
            $search_term = $_GET['search'];


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
                        AND (f.title LIKE '%$search_term%' 
                          || f.description LIKE '%$search_term%' 
                          || f.duration LIKE '%$search_term%'
                          || f.release_date LIKE '%$search_term%'
                          || a.actor_name LIKE '%$search_term%'
                          || c.category_name LIKE '%$search_term%') 
                        GROUP BY f.film_id
                        ";
              
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

          }
          
        }
        
      ?>
             
      
       
          <?php foreach($result as $row): ?> 
            <table id="search_result">
              <tr>
                <td>ID</td><td><?php echo $row['film_id']; ?> </td>
              </tr>
              <tr>
                <td>Title</td><td><?php echo $row['title']; ?> </td>
              </tr>
              <tr>
                <td>Release Year</td><td><?php echo $row['release_date']; ?> </td>
              </tr>
              <tr>
                <td>Duration</td><td><?php echo $row['duration']; ?> </td>
              </tr>
              <tr>
                <td>Description</td><td><?php echo $row['description']; ?> </td>
              </tr>
              <tr>
                <td>Director</td><td><?php echo $row['director_name']; ?> </td>
              </tr>
              <tr>
                <td>Actors</td><td><?php echo $row['actors']; ?> </td>
              </tr>
              <tr>
                <td>Categories</td><td><?php echo $row['categories']; ?> </td>
              </tr>
            </table>  
          <?php endforeach; ?>
       

    
    </section>

    
    <!-- Footer with navigation and Copyright -->
    <footer>
      <section class="wrapper">
        

        <ul>
          <li><a href="index.html" >Home</a></li>
          <li><a href="films.php" >Films</a></li>
          <li><a href="impressum.html" >Impressum</a></li>
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


<!-- http://www.webreference.com/programming/php/search/3.html -->