# What do you expect to happen when the greeting variable is 
# referenced in the last line of the code below?

if false
  greeting = "hello world"
end

p greeting

# Expecting this to raise an exception that greeting isn't defined
# as a local variable or as a method name.

# Since false is always false, the greeting = "hello world"
# line never executes. if it did, greeting would be "hello world"
# since this isn't a block (it comes after a keyword, not after a 
# method invocation)

# I was wrong. From the solution:

# greeting is nil here, and no "undefined method or local variable"
# exception is thrown. Typically, when you reference an uninitialized
# variable, Ruby will raise an exception, stating that it’s undefined.
# However, when you initialize a local variable within an if block,
# even if that if block doesn’t get executed, the local variable is
# initialized to nil.

