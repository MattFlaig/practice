var view = function(){

	var _setup = function(){
		var input = model.get_rows();
		var html = "";

		html += view.build_first_row();
		html += view.build_main_rows(input);
		html += view.build_last_row();
		
		$('#calculator').html(html);
	}

	var _build_first_row = function(){
		return "<row>" +
                "<input type='text' class='col-sm-12' id='calc_input' name='calc_input' readonly/>" +
                "</row>";
	}

	var _build_main_rows = function(input){
		var html = "";
        for(var i = 0; i < 4; i++){
			html += "<row>";
			input[i].forEach(function(element){
				html += "<div class='button col-sm-3' name=" + "'" + element + "'" + ">" + element +"</div>";
			});
			html += "</row>";
		}
		return html;
	}

	var _build_last_row = function(){
		var html = "";
		html += "<row>";
		['C', '='].forEach(function(element){
			html += "<div class='button col-sm-6' id=" + "'" + element + "'" + ">" + element +"</div>";
		});
		html += "</row>";
		return html;
	}

	return {
		setup : _setup,
		build_first_row : _build_first_row,
		build_main_rows : _build_main_rows,
		build_last_row : _build_last_row
	}

	
}();