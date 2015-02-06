<?php
	$servername = "localhost";
	$username = "root";
	$password = "";
	$port = 3306;
	$dbname = "myfilms";
	$options = array(
		PDO::ATTR_PERSISTENT => true,
		PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
		PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true	
	);
?>