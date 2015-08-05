function palindrome(str) {
  var replaced = str.toLowerCase().replace(/\W/g, '');
  console.log(replaced);
  var reversed = replaced.split('').reverse().join('');
  console.log(reversed);
  return reversed == replaced;
}



console.log(palindrome("eye"));
console.log(palindrome("race car"));
console.log(palindrome("A man, a plan, a canal. Panama"));
