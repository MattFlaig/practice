<?php
  
	if ($_POST['calc_input'] != ""){
		$expression = $_POST['calc_input'];
		$arr = explode(" ", $expression);
		$sum = 0;

		if (preg_match("/\/\s0/", $expression)){
            echo "ERROR";
        }
        else{
		    function evaluate($arr, $sum){   
		    
				if (!function_exists('parse')){
				    function parse($arr, $operator){
					    for ($i=0;$i<count($arr);$i++){
							$element = $arr[$i];

							if ($element == $operator){
								switch ($element){ 
									case '*': $new_element = floatval($arr[$i-1]) * floatval($arr[$i+1]);
										break;
									case '/': $new_element = floatval($arr[$i-1]) / floatval($arr[$i+1]);
										break;
									case '%': $new_element = floatval($arr[$i-1]) % floatval($arr[$i+1]);
										break;
									case '-': $new_element = floatval($arr[$i-1]) - floatval($arr[$i+1]);
										break;
									case '+': $new_element = floatval($arr[$i-1]) + floatval($arr[$i+1]);
										break;
								}

								if (count($arr) > 3){
									array_splice($arr, $i-1, 3, $new_element);
									$i=0;
								}
								else{
									$GLOBALS['sum'] += $new_element;
								}
							}	
					    }
					    return $arr;
				    }
				}

				$operators = array('*','/','%','-','+');
				$index = 0;

				while ($index < count($operators)){
					$parsed_array = parse($arr, $operators[$index]);
					$index++;
					$arr = $parsed_array;
				} 
			}

			evaluate($arr, $sum);
			echo $sum;
			
		}

	}
	else{
		echo "ERROR";
	}


?>