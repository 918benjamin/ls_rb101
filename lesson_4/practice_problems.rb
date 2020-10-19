# Problem 1
# What is the return value of the select method below? Why?

# selected = [1, 2, 3].select do |num|
#   num > 5
#   'hi'
# end

# p selected

# # => [1, 2, 3]
# # because the last line of the block is what the select method uses
# # to evaluate each element. 'hi' is truthy, so all the elements
# # are selected and included in the returned block.


# # Problem 2
# # How does count treat the block's return value? How can we find out?

# counted = ['ant', 'bat', 'caterpillar'].count do |str|
#   str.length < 4
# end

# p counted # => 2

# # We can check the documentation for Enumerable#count
# # It says that count treats the blocks return value as the condition
# # to increment count or not for each element


# # Problem 3
# # What is the return value of reject in the following code? Why?

# rejected = [1, 2, 3].reject do |num|
#   puts num
# end

# p rejected # => [1, 2, 3]

# # Enumerable#reject returns a new array with all the elements for which
# # the given block returns false. Since the Kernel#puts method always
# # returns nil, this block will evaluate to false for every number in
# # the calling array.

# # Problem 4
# # What is the return value of each_with_object in the following code? Why?

# ['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
#   hash[value[0]] = value
# end

# => {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}
# The new hash object passed in (empty) as an argument is what will be
# returned, after iterating through the elements of the calling array.
# The given block assigns each value to the first letter of the value
# because value[0] accesses the first letter.


# Problem 5
# What does shift do in the following code? How can we find out?

# hash = { a: 'ant', b: 'bear' }
# p hash.shift # => [:a, 'ant']
# p hash # => {:b => 'bear'}

# We can check the documentation for Hash#shift
# Hash#shift takes a key:value pair from the array (assuming the 1st one)
# and returns it as a two element array [key, value]


# Problem 6
# What is the return value of the following statement? Why?

# p ['ant', 'bear', 'caterpillar'].pop.size # => 11

# Array#pop takes the last element off the array and returns it. This
# returned string (former) element is what calls String#size.


# Problem 7
# What is the block's return value in the following code? How is it
# determined? Also, what is the return value of any? in this code
# and what does it output?

# any = [1, 2, 3].any? do |num|
#   puts num
#   num.odd?
# end

# p any

# The block return value for each iteration is 
# (1) true, (2) false, (3) true 
# The overall return value for the block is true
# True is also the overall return value for the method call

# This code outputs 1, 2, 3 on separate lines and returns true

# I was wrong: since the first iteration 1.odd? evaluates to true,
# that is the only iteration performed and the 1 is the only number
# printed before the whole method returns true


# Problem 8
# How does take work? Is it destructive? How can we find out?

# arr = [1, 2, 3, 4, 5]
# p arr.take(2) # => [1, 2]
# p arr # => [1, 2, 3, 4, 5] (non-destructive)

# We can check the documentation for Array#take!
# Array#take returns the first n elements from the array in a new array,
# where n is the given argument.
# The documentation doesn't specify if the method is destructive,
# but we can find out from running this code or testing take in irb

# Array#take is non-destructive


# Problem 9
# What is the return value of map in the following code? Why?

# { a: 'ant', b: 'bear' }.map do |key, value|
#   if value.size > 3
#     value
#   end
# end

# => [nil, 'bear']
# Map returns an array with the results of running block once for 
# every key:value pair. The first iteration the block returns nil
# because that is what the if statement returns when it evaluates
# to false. The second element is 'bear' because the value is
# returned when the if statement evaluates to true as it does on
# the second iteration.


# Problem 10
# What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# => [1, nil, nil]
# Also puts 2, 3 each on a new line

# Map always returns an array. The elements of that array are determined
# by the return value of the block on each iteration. Since 1 is not 
# greater than 1, the else returns the number itself (1) on the first
# iteration and 1 becomes the first element of the new array.
# The other two numbers are greater than 1, so the puts statement
# executes (printing the number) and returns nil, which is passed
# back to the map method and becomes the second and third element of 
# the new array, which is then returned.