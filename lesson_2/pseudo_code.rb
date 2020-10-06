=begin

1. A method that returns the sum of two integers

## CASUAL ##

Given two integers
Add the first to the second integer
Return the result

## FORMAL ##

START
Given two integers "num1" and "num2"
SET result = num1 + num2
return result

END


2. A method that takes an array of strings, and returns a string that is all those strings concatenated together

## CASUAL ##

Given an array of strings
Set a counter to 0
Set a result variable to an empty string
While counter < the size of the array
  Access the string at the index of counter
  Concatenate that string to the result
  Increment the counter by 1
Return the result

## FORMAL ##

START
Given an array of strings, "arr"
SET counter = 0
SET result = ""
WHILE counter < size of arr
  result = result + arr[1]
  counter = counter + 1
return result

END

3. A method that takes an array of integers, and returns a new array with every other element

## CASUAL ##

Given an array of integers
Set a counter to 1
Set a result variable an array containing the 0th element in the original array
While counter < size of the array
  If counter is odd
    Go to the next iteration
  else
    Add the integer at arr[counter] to the result array
return the result array


## FORMAL ##

START
Given an array of integers, arr
SET counter = 1
SET result = []
result << arr[0]
WHILE counter < size of arr
  If counter is odd
    next
  else
    result << arr[counter]
return result
END

=end