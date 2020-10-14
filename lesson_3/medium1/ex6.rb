# What is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8 

# The output should be 34
# mess_with_it method doesn't mutate answer, because answer is an
# integer it can't e mutated. some_number is reassigned within the
# method, and while that return value is passed to new_answer,
# we don't then use new_answer as an argument to the p method call.