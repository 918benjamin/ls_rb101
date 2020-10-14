# Alyssa was asked to write an implementation of a rolling buffer.
# Elements are added to the rolling buffer and if the buffer becomes
# full, then new elements that are added will displace the oldest
# elements in the buffer.

# She wrote two implementations saying, "Take your pick. Do you like
# << or + for modifying the buffer?". Is there a difference between
# the two, other than what operator she chose to use to add an element
# to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# Yes. The difference is that rolling_buffer1 is mutating the local
# variable passed in as buffer. It adds a new element to the buffer
# initalized outside the method where rolling_buffer2 initializes
# a new variable buffer instead of mutating the variable passed in.

# The other difference is that rolling_buffer2 appends new elements
# as a single dimensional array. (WRONG)

# From testing I realized the above second difference isn't accurate
# because the presented way of using + to add an array element is
# correct and results in adding individual elements, not a nested array.
