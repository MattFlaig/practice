<?php
    require_once '../lib/database.php';

    if (isset($_GET['logout'])){
        session_start();
        session_destroy();
        redirect("login.php");
    }
?>

