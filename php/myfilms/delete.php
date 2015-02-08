<?php
  require_once 'database.php';

  empty($_REQUEST['film_id']) && render404();

  $stmt = $db->prepare('DELETE FROM films WHERE film_id = ?');
  $stmt->execute(array($_REQUEST['film_id']));

  redirect('read.php');
  }
?> 