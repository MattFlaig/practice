(function($){
	$(document).ready(function(){
	  var index = 0;

    $('#show').click(function(event){
        var request = $.ajax({
     		type: "GET",
        url: "crud.json",
        datatype: "json"
     	})
     	request.done(function(){
     		var jsonObject = $.parseJSON(request.responseText);
     		$('#firstName').val(jsonObject[0].firstname);
     		$('#lastName').val(jsonObject[0].lastname);
     	});
  	})


    $('#next').click(function(event){
      var request = $.ajax({
   		  type: "GET",
        url: "crud.json",
        datatype: "json"
    	})
     	request.done(function(){
     		var jsonObject = $.parseJSON(request.responseText);
     		if(index+1 != jsonObject.length){
	        index += 1;
        }
     		$('#firstName').val(jsonObject[index].firstname);
     		$('#lastName').val(jsonObject[index].lastname);
     	});
  	}) 


  	$('#latest').click(function(event){
      var request = $.ajax({
   		  type: "GET",
        url: "crud.json",
        datatype: "json"
    	})
     	request.done(function(){
     		var jsonObject = $.parseJSON(request.responseText);
     		if(index != 0){
	        index -= 1;
        }
     		$('#firstName').val(jsonObject[index].firstname);
     		$('#lastName').val(jsonObject[index].lastname);
     	});
  	}) 
    	
	});
}($));



// function showFirstItem(){
// 	if (window.XMLHttpRequest){
// 	  xhttp=new XMLHttpRequest();
// 	}
// 	else{
// 	  xhttp=new ActiveXObject("Microsoft.XMLHTTP");
// 	}

//   xhttp.onreadystatechange = function(){
//   	if(xhttp.readyState == 4){
//   		var jsonObject = JSON.parse(xhttp.responseText);
//   		document.getElementById("firstName").value = jsonObject[0].firstname;
//   		document.getElementById("lastName").value = jsonObject[0].lastname;
//   	}
//   }

// 	xhttp.open("GET","crud.json",true);
// 	xhttp.send();
// }

// function getNextItem(){
// 	if (window.XMLHttpRequest){
// 	  xhttp=new XMLHttpRequest();
// 	}
// 	else{
// 	  xhttp=new ActiveXObject("Microsoft.XMLHTTP");
// 	}

//   xhttp.onreadystatechange = function(){
//   	if(xhttp.readyState == 4){
//   		var jsonObject = JSON.parse(xhttp.responseText);
//   		if(index+1 != jsonObject.length){
//   	    index += 1;
//       }
//   		document.getElementById("firstName").value = jsonObject[index].firstname;
//   		document.getElementById("lastName").value = jsonObject[index].lastname;
//   	}
//   }

// 	xhttp.open("GET","crud.json",true);
// 	xhttp.send();
// }

// function getLatestItem(){
// 	if (window.XMLHttpRequest){
// 	  xhttp=new XMLHttpRequest();
// 	}
// 	else{
// 	  xhttp=new ActiveXObject("Microsoft.XMLHTTP");
// 	}

//   xhttp.onreadystatechange = function(){
//   	if(xhttp.readyState == 4){
//   		var jsonObject = JSON.parse(xhttp.responseText);
//   		if (index != 0){
//   	    index -= 1;
//   	  }
//   		document.getElementById("firstName").value = jsonObject[index].firstname;
//   		document.getElementById("lastName").value = jsonObject[index].lastname;
//   	}
//   }

// 	xhttp.open("GET","crud.json",true);
// 	xhttp.send();
// }

// function createNewItem(){
// 	document.getElementById("firstName").value = "";
// 	document.getElementById("lastName").value = "";
// 	var saveButton = document.createElement('button');
// 	var idAttribute = document.createAttribute('id');
// 	idAttribute.setAttribute("id", "save");
// 	var buttonText = document.createTextNode('Save');
// 	saveButton.appendChild(text);
// 	saveButton.appendChild(idAttribute);

// }





