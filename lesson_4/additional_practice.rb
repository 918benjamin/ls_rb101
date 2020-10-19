# Problem 1
# Given the array below

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values
# are the positions in the array.

# new_hash = flintstones.each_with_object({}) do |value, hash|
#   hash[value] = flintstones.index(value)
# end

# p new_hash

# Solution creates an empty hash outside the method call, then calls
# Enumerable#each_with_index to perform this.


# Problem 2
# Add up all of the ages from the Munster family hash:

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# p ages.to_a.flatten.sum { |element| element.to_i }

# sum_all_ages = 0
# ages.each { |_, value| sum_all_ages += value}
# p sum_all_ages

# After looking at the solution: 
# ages.values.inject(:+)
# ages.values.sum


# Problem 3
# In the age hash:

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# remove people with age 100 and greater

# ages = ages.select { |_, value| value >= 100 }
# p ages

# From solution:
# Could also have used the mutating #select! method
# Could also have used the Hash#keep_if method but they do have subtle
# differences and I didn't know this method existed.


# Problem 4
# Pick out the miminum age from our current Munster family hash:

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# minimum_age = ages.values.sort.first
# p minimum_age
# p ages

# Could have also used the Array#min method if known
# ages.values.min


# Problem 5
# In the array:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Find the index of the first name that starts with "Be"
# result = nil

# flintstones.each_with_index do |name, index|
#   if name[0, 2] == "Be"
#     result = index
#   end
# end

# p result

# Solution:
# Could have used:
# flinstones.index { |name| name[0, 2] == "Be" }


# Problem 6
# Amend this array so that the names are all shortened to just the
# first three characters:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones.map! { |name| name[0, 3] }

# p flintstones


# Problem 7
# Create a hash that expresses the frequency with which each letter
# occurs in this string:

# statement = "The Flintstones Rock"
# chars = statement.chars.sort
# chars.select! { |char| char if char != ' ' }

# char_count = {}
# chars.each_with_object(char_count) do |char|
#   if char_count[char] == nil
#     char_count[char] = 1
#   else
#     char_count[char] += 1
#   end
# end

# p char_count


# Problem 8
# What happens when we modify an array while we are iterating over it?
# What would be output by this code?

# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end

# p numbers # => [3, 4]

# prints 1, 3 

# What would be output by this code?

# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.pop(1)
# end

# p numbers # => [1, 2]

# Prints 1, 2 on separate lines


# Problem 9
# As we have seen previously we can use some built-in string methods
# to change the case of a string. A notably missing method is something
# provided in Rails, but not in Ruby itself...titleize. This method in
# Ruby on Rails creates a string that has each word capitalized as it
# would be in a title. For example, the string:

# words = "the flintstones rock"

# would be:

# words = "The Flintstones Rock"

# Write your own version of the rails titleize implementation.
# words.capitalize!

# chars = words.chars
# chars = chars.each_with_index do |char, index|
#   if chars[index - 1] == ' '
#     char.upcase!
#   end
# end

# words = chars.join

# p words

# I went way more granular here than I needed to.
# Solution shows that I could have split into an array of words then
# mapped each word to the capitalized version of the word

# p words.split.map { |word| word.capitalize }.join(' ')

# p words


# Problem 10
# Given the munsters hash below:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an
# additional "age_group" key that has one of three values describing
# the age group the family member is in (kid, adult, or senior).
# Your solution should produce the hash below

# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
#   "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
#   "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
#   "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
#   "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

munsters.each do |key, value|
  if value["age"].between?(0, 17)
    value["age_group"] = 'kid'
  elsif value["age"].between?(18, 64)
    value["age_group"] = 'adult'
  else
    value["age_group"] = 'senior'
  end
end

p munsters