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
		PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true,
		PDO::ATTR_EMULATE_PREPARES => true
	);

	$db = new PDO("mysql:host=$servername;port=$port;dbname=$dbname", $username, $password, $options);
    $db->query('SET NAMES utf8');

	function render404(){
		header("HTTP/1.0 404 Not Found");
		echo "Site Not Found.";
		exit();
	}

	function redirect($url){
		header("Location: $url");
		exit();
	}

	function logged_in(){
		if (isset($_SESSION["admin"])){
			return true;
		}
		else{
			return false;
		}
	}
?>