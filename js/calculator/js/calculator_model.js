var model = function(){
    var last_input = '';

	var _button_rows = [ ['1','2','3',' + '],
						['4','5','6',' - '],
						['7','8','9',' * '],
						['0','.',' % ',' / '],
						['C', '='] ];

	var _nums = ['1','2','3','4','5','6','7','8','9','0'];

	var _operators = ['+', '-', '*', '/', '%'];

	var _get_rows = function(){
		return _button_rows; 
	}

	var _get_nums = function(){
        return _nums;
	}

	var _get_operators = function(){
		return _operators;
	}

	var _parse_input = function(input){
      if (input.search('+') != -1) {
      
      }
	}

    var _get_last_input = function(){
      return last_input;
    }

	var _set_last_input = function(new_input){
      last_input = new_input;
	}

	return {
		get_rows : _get_rows,
		parse_input : _parse_input,
		set_last_input : _set_last_input,
		get_last_input : _get_last_input,
		get_nums : _get_nums,
		get_operators : _get_operators
	}
	
}();