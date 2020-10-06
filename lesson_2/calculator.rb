require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

# puts MESSAGES.inspect

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i.to_s == num
end

def operation_to_message(op)
  result = case op
           when '+' then 'Adding'
           when '-' then 'Subtracting'
           when '*' then 'Multiplying'
           when '/' then 'Dividing'
           end
  result
end

# Get the first number and store it in a variable num1
prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['invalid_name'])
  else
    break
  end
end

prompt("Hi #{name}")

loop do # main loop
  num1 = ''
  loop do
    prompt(MESSAGES['give_num1'])
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  # Get the second number and store it in a variable num2
  num2 = ''
  loop do
    prompt(MESSAGES['give_num2'])
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  # Get the operator and store it in a variable operator
  prompt(MESSAGES['give_operation'])

  operator = ''
  loop do
    operator = gets.chomp
    if %w(+ - * /).include?(operator)
      break
    else
      prompt(MESSAGES['invalid_operation'])
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."
  num1 = num1.to_i
  num2 = num2.to_i

  # Calculate the result depending on the users operator input
  result = case operator
           when '+' then num1 + num2
           when '-' then num1 - num2
           when '*' then num1 * num2
           when '/' then num1.to_f / num2
           else
             prompt(MESSAGES['invalid_operation'])
             return
           end

  # Print the result
  prompt "#{num1} #{operator} #{num2} = #{result}"

  prompt(MESSAGES['again'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['thank_you'])
