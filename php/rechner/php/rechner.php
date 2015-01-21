<?php
  $expression = $_POST['calc_input'];
  $result = eval(" return ($expression);");
  echo $result;


  //explode und implode verwenden
?>