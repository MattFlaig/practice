var controller = function(){
	var _get_index = function(){
		view.setup();
	}

	return {
		get_index : _get_index
	}
}();

$(document).ready(function(){
	controller.get_index();
});