# How could the unnecessary duplication in this method be removed?

# def color_valid(color)
#   if color == "blue" || color == "green"
#     true
#   else
#     false
#   end
# end

# def color_valid(color)
#   case color
#   when "blue" then true
#   when "green" then true
#   else false
#   end
# end

# def color_valid(color)
#   if color == ("blue" || "green")
#     true
#   else
#     false
#   end
# end

# From the solution:

def color_valid(color)
  color == "blue" || color == "green"
end

# This returns true or false by implicit return
# if either is true, returns true. if both are true, returns true (not possible)
# if neither is true, returns false!
# if the first one, color == 'blue' is true will return true without checking
# the second one anyway because of short circuit evaluation.