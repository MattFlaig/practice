function findLongestWord(str) {
  var arr = str.split(' ');
  var longest = 0;
  for(var word in arr){
    if (arr[word].length > longest){
      longest = arr[word].length;
    }
  }
  return longest;
}

findLongestWord('The quick brown fox jumped over the lazy dog');