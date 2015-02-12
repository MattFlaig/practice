<?php
    require_once '../lib/database.php';

    session_start();

    if (logged_in()){


        #Fetching directors, actors and categories
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



        #Processing the form input for directors, actors, categories
        if(isset($_POST["director_name"]) && !empty($_POST["director_name"]) && ctype_alnum($_POST["director_name"]))
        {

            $stmt = $db->prepare('INSERT INTO directors (director_name)VALUES(:director_name)');

            $stmt->execute(array(':director_name'=> $_POST['director_name']));
            unset($stmt);
            redirect("create_names.php");

        }

        if(isset($_POST["actor_name"]) && !empty($_POST["actor_name"]) && ctype_alnum($_POST["actor_name"])){
            $stmt = $db->prepare('INSERT INTO actors (actor_name)VALUES(:actor_name)');

            $stmt->execute(array(':actor_name'=> $_POST['actor_name']));
            unset($stmt);
            redirect("create_names.php");

        }

        if(isset($_POST["category_name"]) && !empty($_POST["category_name"]) && ctype_alnum($_POST["category_name"])){
            $stmt = $db->prepare('INSERT INTO categories (category_name)VALUES(:category_name)');

            $stmt->execute(array(':category_name'=> $_POST['category_name']));
            unset($stmt);
            redirect("create_names.php");

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
        <link rel="stylesheet" href="../css/tabcontent.css"  type="text/css" />

        <script src="../js/jquery.min.js"></script>
        <script src="../js/tabcontent.js" type="text/javascript"></script>
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
                    <li><a href="logout.php?logout=true"  >Logout</a></li>
                <?php endif; ?>
            </ul>
        </nav>
    </header>

    <!-- Spacer for SVG random colour image -->
    <section id="spacer">
    </section>


    <!-- Main Section -->
    <section id="main">
        <h1>Add new directors, actors, categories</h1>

        <div id="container">

            <!-- tabnavigation for adding new entries -->
            <ul class="tabs">
                <li><a href="#directors">Directors</a>
                </li>
                <li><a href="#actors">Actors</a>
                </li>
                <li><a href="#categories">Categories</a>
                </li>
            </ul>

            <div class="tabcontents" >
                <div id="directors">
                    <form id="create_film" action=' <?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>' method="post">
                        <table>
                            <tr>
                                <td><label>Director Name</label></td><td><input type="text" name="director_name" /></td>
                            </tr>
                        </table>

                        <p>
                            <input id="form_button" type="submit" value="Save Director">
                        </p>
                    </form>
                    </br>
                    
                </div>
                <div id="actors">
                    <form id="create_film" action=' <?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>' method="post">
                        <table>
                            <tr>
                                <td><label>Actor Name</label></td><td><input type="text" name="actor_name" /></td>
                            </tr>
                        </table>

                        <p>
                            <input id="form_button" type="submit" value="Save Actor">
                        </p>
                    </form>
                </div>
                <div id="categories">
                    <form id="create_film" action=' <?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>' method="post">
                        <table>
                            <tr>
                                <td><label>Category Name</label></td><td><input type="text" name="category_name" /></td>
                            </tr>
                        </table>

                        <p>
                            <input id="form_button" type="submit" value="Save Category">
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </br>
    </br>


        <h1>Show Directors, Actors, Categories</h1>
        <div id="container">

            <!-- tabnavigation for db entries -->
            <ul class="tabs">
                <li><a href="#db_directors">Directors</a>
                </li>
                <li><a href="#db_actors">Actors</a>
                </li>
                <li><a href="#db_categories">Categories</a>
                </li>
            </ul>

            <div class="tabcontents" >
                
                <div id="db_directors">
                    <section>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Director</th>
                            </tr>
                      
                        <?php foreach($directors as $row) : ?>
                            <tr>
                                <td><?php echo $row['director_id']; ?> </td>
                                <td><?php echo $row['director_name']; ?> </td>
                            </tr>
                        <?php endforeach ?>
                        </table>
                    </section>
                    </br>
                </div>
                
                <div id="db_actors">
                    <section>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Actor</th>
                            </tr>
                      
                        <?php foreach($actors as $row) : ?>
                            <tr>
                                <td><?php echo $row['actor_id']; ?> </td>
                                <td><?php echo $row['actor_name']; ?> </td>
                            </tr>
                        <?php endforeach ?>
                        </table>
                    </section>
                </div>

                <div id="db_categories">
                    <section>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Category</th>
                            </tr>
                      
                        <?php foreach($categories as $row) : ?>
                            <tr>
                                <td><?php echo $row['category_id']; ?> </td>
                                <td><?php echo $row['category_name']; ?> </td>
                            </tr>
                        <?php endforeach ?>
                        </table>
                    </section>
                </div>
            </div>
        </div>

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