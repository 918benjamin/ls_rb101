# --- QUESTION 1 --- #
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# Prints out the original array because uniq is non-destructive

# More detail in the solution:
# Since puts method calls .to_s on its argument, this prints out each element
# of the original numbers array on a separate line.
# The p method calls .inspect on its argument which is why it prints out the
# original formatting for whatever the object is.


# --- QUESTION 2 --- #
# Describe the difference between ! and ? in Ruby.
# And explain what would happen in the following scenarios:

# ! is the bang operator. It is used as a way to flip the boolean value of an
# object and as a naming convention to show methods that are destructive.

# ? is used in ternary operator in place of an if..else statement. It is also 
# used as a naming convention for methods that return a boolean value.

# 1. What is != and where should you use it?
# this is equivalent to "not equal" and can be used in conditional statements

# 2. Put ! before something, like !user_name
# This flips the boolean value of user_name. If it is nil, makes it true.
# If it is a valid value, makes its boolean value false.

# 3. put ! after something, like words.uniq!
# This is a naming convention and won't do anything on its own. If a method
# using the ! at the end exists, this is typically to show that the method is
# destructive and will mutate the caller.

# 4. put ? before something
# Creates a ternary expression, and will only execute what follows the ? if
# What comes before it evaluates to true.

# 5. put ? after something
# Checks to see if that thing is true to decide if the code after the ? should
# be executed or not. If ? comes after a method name (as part of the name) it
# is a naming convention used to show that a method will return a boolean value

# 6. put !! before something, like !!user_name
# This is redundant, the same as simply putting user_name when used in
# a conditional statement. However, I think this is to demonstrate the intent
# of using the actual boolean value of user_name, to show that it is not a
# typo or error. Kind of like using parentheses when you use variable assignment
# as a conditional, to demonstrate it was intentional.

# From solution: Not quite.
# The !!<some object> is used to turn any object into their boolean equivalent


# --- QUESTION 3 --- #
# Replace the word "important" with "urgent" in this string

# One way, accessing words as elements in an array
advice = "Few things in life are as important as house training your pet dinosaur."

advice = advice.split(' ')
advice[6] = 'urgent'
advice = advice.join(' ')

# Another, using gsub
advice = "Few things in life are as important as house training your pet dinosaur."

advice.gsub!('important', 'urgent')

# --- QUESTION 4 --- #
# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

# What do the following method calls do (assume we reset numbers to the original
# array between method calls)?

numbers.delete_at(1)
# This method deletes the element at index 1, the second element, which in this
# array is the integer 2. This returns the number deleted, 2, and mutates the array
# removing 2.

# reset numbers
numbers = [1, 2, 3, 4, 5]

numbers.delete(1)
# This method deletes the element passed as an argument from the calling arroy.
# This will remove the integer 1 and return it, mutating the array to [2, 3, 4, 5]
# This method will also delete all instances of the argument passed to it.
# So in the array [1, 1, 2, 3, 4, 5] .delete(1) will return 1 and mutate the array
# to [2, 3, 4, 5]

# These are both examples of destructive methods that do not end with an !

# --- QUESTION 5 --- #
# Programatically determine if 42 lies between 10 and 100
# hint: Use Ruby's range object in your solution

# An option using a for loop
for i in 11...100 do
  if i == 42
    puts "42 is in there!"
  else
    next
  end
end

# Another option using just conditionals
# I guess this isn't programmatic maybe but it works
if 42 > 10 && 42 < 100
  puts "42 is in there!"
else
  puts "Not there."
end

# Another option using the .each iterator
(11...100).each do |i|
  puts "42 is in there!" if i == 42
end

# From the solution:
# Uses the Range#cover? method which returns true if the argument passed is
# in the calling range, false if not.

(11...100).cover?(42)

# --- QUESTION 6 --- #
# Starting with the string:

famous_words = 'seven years ago...'

# Show two different ways to put the expected "Four score and " in front of it.

famous_words = "Four score and " + famous_words

# Reset the string
famous_words = 'seven years ago...'

famous_words = "Four score and " << famous_words

# Another option from the solution
# String#prepend method
# Prepends the argument(s) to the calling string

# Another option would be the String#concat method


# --- QUESTION 7 --- #
# If we build an array like this:

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

# Make this into an un-nested array
flintstones.flatten!


# --- QUESTION 8 --- #
# Given the hash below

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

arr = flintstones.slice("Barney").to_a.flatten!

# This works but the solution uses the Hash#assoc method