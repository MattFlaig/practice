<?php
    require_once 'database.php';

    session_start();

    if (logged_in()){

        empty($_REQUEST['film_id']) && render404();


        $stmt = $db->prepare('SELECT * FROM actors, actors_films WHERE film_id = ? AND actors_films.actor_id = actors.actor_id');
        $stmt->execute(array('film_id'));
        $actors = $stmt->fetchAll();
        unset($stmt);

        foreach ($actors as $act) :
        $stmt = $db->prepare("DELETE FROM actors_films WHERE film_id = ? AND actor_id = $act.actor_id");
        endforeach;
        $stmt->execute(array($_REQUEST['film_id']));
        unset($stmt);



        $stmt = $db->prepare('SELECT * FROM categories, categories_films WHERE film_id = ? AND categories_films.category_id = categories.category_id');
        $stmt->execute(array('film_id'));
        $categories = $stmt->fetchAll();
        unset($stmt);

        foreach ($categories as $cat) :
        $stmt = $db->prepare("DELETE FROM actors_films WHERE film_id = ? AND category_id = $cat.category_id");
        endforeach;
        $stmt->execute(array($_REQUEST['film_id']));
        unset($stmt);


        $stmt = $db->prepare('DELETE FROM films WHERE film_id = ?');
        $stmt->execute(array($_REQUEST['film_id']));

        redirect('../user/films.php');

    }
    else{
        redirect('../index.php');
    }
?> 