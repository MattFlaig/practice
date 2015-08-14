function titleCase(str) {
  var arr = str.split(' ');
  for(var i=0; i<arr.length; i++){
    var word = arr[i];
    arr[i] = word.charAt(0).toUpperCase() + word.toLowerCase().slice(1);
  }
  return arr.join(' ');
}

titleCase("I'm a little tea pot");