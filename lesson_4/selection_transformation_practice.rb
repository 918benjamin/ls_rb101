# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }

# def select_fruit(produce)
#   fruit = {}
#   keys = produce.keys

#   for key in keys
#     produce[key]
#     if produce[key] == 'Fruit'
#       fruit[key] = produce[key]
#     end
#   end

#   fruit
# end
  

# p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
# p produce



# def multiply!(numbers, num)
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     numbers[counter] *= num

#     counter += 1
#   end

#   numbers
# end

# p my_numbers = [1, 4, 3, 7, 2, 6]
# p multiply!(my_numbers, 3)
# p my_numbers



# def double_odd_indices(numbers)
#   doubled_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     current_number = numbers[counter]
#     current_number *= 2 if counter.odd?
#     doubled_numbers << current_number

#     counter += 1
#   end

#   doubled_numbers
# end

# p my_numbers = [1, 4, 3, 7, 2, 6]
# p double_odd_indices(my_numbers)  # => [1, 8, 3, 14, 2, 12]

# # not mutated
# p my_numbers                      # => [1, 4, 3, 7, 2, 6]


def select_letter(str, char)
  new_str = ""
  counter = 0

  loop do
    break if counter == str.length

    if str[counter] == char
      new_str << str[counter]
    end

    counter += 1
  end

  new_str
end



question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a') == "aaaaaaaa"
p select_letter(question, 't') == "ttttt"
p select_letter(question, 'z') == ""
p select_letter(question, 'a').size == 8
p select_letter(question, 't').size == 5
p select_letter(question, 'z').size == 0