var view = function(){

	var _setup = function(){
		view.load_calculator();
		view.load_event_handler();
		view.load_digital_nums();
	}

	var _load_event_handler = function(){
		/*$('#calculator').on('click', '.calc', function(){
			var new_input = $(this).attr('name');
			var last_input = model.get_last_input().trim();
			var old_input = $('#calc_input').val();
			var nums = model.get_nums();

			if(new_input == '.'){
              $("[name='.']").removeClass('calc');
			}
			else{
				if(nums.indexOf(new_input) >= 0){
					$('#calc_input').val(old_input + new_input);
				}
				else{
					if(nums.indexOf(last_input) >= 0){
						$('#calc_input').val(old_input + new_input);
					}
					$("[name='.']").addClass('calc');
				}
			}

			model.set_last_input(new_input);
		})

		$('#calculator').on('click', '#C', function(){
			$('#calc_input').val('');
		})*/

	}

	var _load_digital_nums = function(){
		html = "<div class='digital_num'><div class='num1'></div><div class='num2'></div><div class='num3'></div>" +
		"<div class='num4'></div><div class='num5'></div><div class='num6'></div><div class='num7'></div></div>";
		$('#calc_input').html(html);

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
		return "<row><div class='col-sm-12' id='calc_input' name='calc_input'> </div></row>";
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
		load_event_handler : _load_event_handler,
		load_digital_nums : _load_digital_nums
	}

	
}();



/* map:
[
  [0],[0],[1],
     ,[0],,
  [0],[0],[1]
], 37

{ 0 : '123567',
  1 : '37',
  2 : '23456',
  4 : '1347',
  5 : '12467',
  6 : '124567',
  7 : '237',
  8 : '1234567',
  9 : '123467'}

  */