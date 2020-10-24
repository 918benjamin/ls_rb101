# Given this code, what would be the final values of a and b?
# Try to work this out without running the code.

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# a => 4
# b => [1, 8]
# WRONG:
# a is pointing to an integer which is immutable, so when arr[0] is
# reassigned to its value + 2, arr[0] is pointing to a new object, which
# is different than a, so a keeps its original value of 2.
# Since b is pointing to an array which is mutable, whne arr[1][0]
# reassigns the value to itself minus a (at this point a is still 2),
# both b and arr are changed because they are both pointing to the 
# same array object. 


p a
p b
p arr
