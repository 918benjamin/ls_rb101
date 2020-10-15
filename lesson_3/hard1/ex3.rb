# In other practice problems, we have looked at how the scope of
# variables affects the modification of one "layer" when they are
# passed to another.

# To drive home the salient aspects of variable scope and modification
# of one scope by another, consider the following similar sets of code.

# What will be printed by each of these code groups?

# A)

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"     # => 'one'
puts "two is: #{two}"     # => 'two'
puts "three is: #{three}" # => 'three'

# The variables are reassigned inside the method but that has no
# impact on the objects that the variables outside the method point to.
# The outside variables are indeed passed into the variable, but
# reassignment changes the objects that the variables inside the method
# point to and do no mutate any objects themselves.

# B) 

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"     # => 'one'
puts "two is: #{two}"     # => 'two'
puts "three is: #{three}" # => 'three'

# Same thing as above. Even though the objects reassigned are strings
# and not other variables, the reassignment is still not mutating
# to the outside scope variables.

# C)

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"     # => 'two'
puts "two is: #{two}"     # => 'three'
puts "three is: #{three}" # => 'one'

# Here, String#gsub! is mutating, so calling this method on the method
# variables mutates the objects they point to, the same objects the
# outer scope variables point to. So the outer scope variables objects
# are mutated.