# Alan wrote the following method, which was intended to show all of
# the factors of the input number:

def factors(number)
  divisor = number
  factors = []
  # return "invalid input" if number <= 0
  # begin
  #   factors << number / divisor if number % divisor == 0
  #   divisor -= 1
  # end until divisor == 0
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Alyssa noticed that this will fail if the input is 0, or a negative
# number, and asked Alan to change the loop. How can you make this
# work without using begin/end/until? Note that we're not looking to
# find the factors for 0 or negative numbers, but we just want to
# handle it gracefully instead of raising an exception or going into
# an infinite loop.

puts factors(0)
puts factors(-1)
puts factors(10)

# Bonus 1 - What is the purpose of the number % divisor == 0 ?

# This is the check to see if the current divisor results in a
# valid factor of the given number.

# Bonus 2 - What is the purpose of the second-to-last line
# (line 8) in the method (the factors before the method's end)?

# This line ensures that the method will return factors instead of 
# whatever is returned by the begin..end block