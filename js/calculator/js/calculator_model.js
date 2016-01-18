var model = function(){
	var _button_rows = [ ['1','2','3','+'],
						['4','5','6','-'],
						['7','8','9','*'],
						['0','.','%','/'],
						['C', '='] ];

	var _get_rows = function(){
		return _button_rows; 
	}

	return {
		get_rows : _get_rows
	}
	
}();