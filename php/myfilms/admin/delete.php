<?php
    require_once '../lib/database.php';

    session_start();

    if (logged_in()){

        empty($_REQUEST['film_id']) && render404();

        #Delete records from join tables
        $stmt = $db->prepare("DELETE FROM actors_films WHERE film_id = ?");
        $stmt->execute(array($_REQUEST['film_id']));
        unset($stmt);
  
        $stmt = $db->prepare("DELETE FROM categories_films WHERE film_id = ?");
        $stmt->execute(array($_REQUEST['film_id']));
        unset($stmt);

        #Delete record from main table
        $stmt = $db->prepare('DELETE FROM films WHERE film_id = ?');
        $stmt->execute(array($_REQUEST['film_id']));

        redirect('../user/films.php');

    }
    else{
        redirect('../index.php');
    }
?> 