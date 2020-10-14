# The result of the following statement will be an error:

# puts "the value of 40 + 2 is " + (40 + 2)

# Why is this and what are two possible ways to fix this?

# Why? Because Ruby won't combine a string and an integer without
# us specifying that we want the integer to be treated as a string

# Fix it - Method 1
# String interpolation

puts "the value of 40 + 2 is #{40 + 2} "

# Fix it - Method 2
# Convert the result of (40 + 2) to a string with to_s

puts "the value of 40 + 2 is " + (40 + 2).to_s