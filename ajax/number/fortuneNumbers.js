function getRequest(){
	var ajaxRequest;

	ajaxRequest = new XMLHttpRequest();
	ajaxRequest.onreadystatechange = function(){
	  if (ajaxRequest.readyState == 4){
	    document.myForm.number.value = ajaxRequest.responseText; 
	  }
	}
	ajaxRequest.open("GET","myFortuneNumber.php",true);
	ajaxRequest.send(null);
}