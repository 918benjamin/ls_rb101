# Write a method called joinor

def joinor(arr, delim=', ', conj='or')
  if arr.size < 2
    arr.join(delim)
  else
    last_item = arr.pop
    arr.join(delim) + delim + conj + ' ' + last_item.to_s
  end
end

# Possible Solution given
# def joinor(arr, delimiter=', ', word='or')
#   case arr.size
#   when 0 then ''
#   when 1 then arr.first
#   when 2 then arr.join(" #{word} ")
#   else
#     arr[-1] = "#{word} #{arr.last}"
#     arr.join(delimiter)
#   end
# end

# I actually prefer my solution because it accomplishes the same outcome
# in a bit simpler package. it does mutate the array passed in, but in this
# case that doesn't matter since the array is only created for this purpose.


p joinor([])
p joinor([1])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"