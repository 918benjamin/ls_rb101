# --- QUESTION 1 --- #
# In this hash of people and their age,

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# see if "Spot" is present.

ages.include?("Spot")

# Bonus: What are two other hash methods that would work just as well for this solution?

# Hash#member method
ages.member?("Spot")

# Hash#has_key? method
ages.has_key?("Spot")
ages.key?("Spot") # Rubocop prefers .key? over .has_key?


# --- QUESTION 2 --- #
# Starting with this string:

munsters_description = "The Munsters are creepy in a good way."

# Convert th string in the following ways
# (code will be executed on original munsters_description above):

# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.swapcase!

# reset string
munsters_description = "The Munsters are creepy in a good way."

# "The munsters are creepy in a good way."
munsters_description.capitalize!

# reset string
munsters_description = "The Munsters are creepy in a good way."

# "the munsters are creepy in a good way."
munsters_description.downcase!

# reset string
munsters_description = "The Munsters are creepy in a good way."

# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.upcase!


# --- QUESTION 3 --- #
# We have most of the Munster family in our age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

# add ages for Marilyn and Spot to the existing hash

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

# --- QUESTION 4 --- #
# See if the name "Dino" appears in the string below:

advice = "Few things in life are as important as house training your pet dinosaur."

advice.include?("Dino")

# Solution uses String#match? which converts the given argument to a regex in
# order to search the calling string. 


# --- QUESTION 5 --- #
# Show an easier way to write this array:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)


# --- QUESTION 6 --- #
# How can we add the family pet "Dino" to our usual array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones << "Dino"


# --- QUESTION 7 --- #
# In the previous practice problem we added Dino to our array with <<.
# We could have used either Array#concat or Array#push to add Dino to the family.

# How can we add multiple items to our array? (Dino and Hoppy)

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.concat(["Dino", "Hoppy"])
# OR
flinstones.push("Dino", "Hoppy")
# OR
flintstones.push("Dino").push("Hoppy") # Can do this because push method returns the modified array


# --- QUESTION 8 --- #
# Shorten this sentence:

advice = "Few things in life are as important as house training your pet dinosaur."

# ...remove everything starting from "house".
# Review the String#slice! documentation, and use that method to make the 
# return value "Few things in life are as important as ". But leave the advice
# variable as "house training your pet dinosaur.".

advice.slice!(0..38)

# Solution gives a less hard-coded version
advice.slice!(0, advice.index('house'))


# --- QUESTION 9 --- #
# Write a one-liner to count the number of lower-case 't' characters in the following string:

statement = "The Flintstones Rock!"

statement.chars.count('t')
# Solution showed I didn't need to use .chars, I can call .count('t') directly
# on the statement. String#count method documentation was confusing


# --- QUESTION 10 --- #
# Back in the stone age (before CSS) we used spaces to align things on the screen.
# If we had a 40 character wide table of Flintstone family members, how 
# could we easily center that title above the table with spaces?

title = "Flintstone Family Members"
spaces = (40 - title.length) / 2
title = (" " * spaces) + title + (" " * spaces)