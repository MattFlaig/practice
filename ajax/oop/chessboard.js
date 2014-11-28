var Chessboard = (function () {
	function Chessboard(rowLength, columnLength){
	  this.rowLength = rowLength;
	  this.columnLength = columnLength;
	  this.createBoard(rowLength, columnLength);
	}
	Chessboard.prototype.createBoard = function(rowLength, columnLength){
    var table = document.createElement('table');
    for(var i=0;i<rowLength;++i){
  	var row = document.createElement('tr');
  	
    for(var j=0;j<columnLength;++j){
      var cell = document.createElement('td');
      if (j%2==0 && i%2==0){
      	cell.style.setProperty("background-color","black");
      }
      else if(j%2!=0 && i%2!=0){
      	cell.style.setProperty("background-color","black");
      }
      row.appendChild(cell);
	    }
	    table.appendChild(row);
	  }
	  var board = document.getElementById('board');
    board.appendChild(table);
	}
	return Chessboard;
})();