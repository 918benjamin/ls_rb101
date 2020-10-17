=begin

PROBLEM:

Given a string, write a method `palindrome_substrings` which returns
all the substrings from a given string which are palindromes. Consider
palindrome words case sensitive.

Test cases:

palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
palindrome_substrings("palindrome") == []
palindrome_substrings("") == []

*** PEDAC ****

Understand the problem
- Input: string
- output: array of strings
- requirements (explicit/implicit)
  - If no palindromes, return empty array
  - If empty string given, return empty array
  - Palindrome words are case sensitive
  - Substrings are down to two characters
- Implicit knowledge / problem domain keywords or concepts
  - Palindrome is the same backwards and forwards
- questions / clarify
  - What if there are numbers in the string?
  - What is a substring?
  - Whatis a palindrome?
  - What does it mean to consider palindrome words case sensitive?

Data structures
- Input: string
- output: array of strings
- Intermediate:
  - array of substringss
=end