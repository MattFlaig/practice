var view = function(){

	var _setup = function(){
		view.load_calculator();
		view.load_event_handler();
	}

	var _load_event_handler = function(){
		$('#calculator').on('click', '.calc', function(){
			console.log($(this).attr('name'));
			var input = $(this).attr('name');
			var old_input = $('#calc_input').val();
			$('#calc_input').val(old_input + input);
		})
	}

	var _load_calculator = function(){
        var rows = model.get_rows();
		var html = "";

		html += view.build_first_row();
		html += view.build_main_rows(rows);
		html += view.build_last_row();
		
		$('#calculator').html(html);
	}

	var _build_first_row = function(){
		return "<row>" +
                "<input type='text' class='col-sm-12' id='calc_input' name='calc_input' readonly/>" +
                "</row>";
	}

	var _build_main_rows = function(rows){
		var html = "";
        for(var i = 0; i < 4; i++){
			html += "<row>";
			rows[i].forEach(function(element){
				html += "<div class='calc button col-sm-3' name=" + "'" + element + "'" + ">" + element +"</div>";
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
		build_last_row : _build_last_row,
		load_calculator : _load_calculator,
		load_event_handler : _load_event_handler
	}

	
}();