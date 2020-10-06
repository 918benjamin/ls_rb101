def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '+' then 'Adding'
  when '-' then 'Subtracting'
  when '*' then 'Multiplying'
  when '/' then 'Dividing'
  end
end

# Get the first number and store it in a variable num1
prompt('Welcome to Calculator! Enter your name:')

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt "Make sure to use a valid name."
  else
    break
  end
end

prompt "Hi #{name}!"

loop do # main loop
  num1 = ''
  loop do
    prompt 'Give me a number:'
    num1 = gets.chomp.to_i

    if valid_number?(num1)
      break
    else
      prompt "Hmm... that doesn't look like a valid number"
    end
  end

  # Get the second number and store it in a variable num2
  num2 = ''
  loop do
    prompt 'Give me a second number:'
    num2 = gets.chomp.to_i

    if valid_number?(num2)
      break
    else
      prompt "Hmm... that doesn't look like a valid number"
    end
  end

  # Get the operator and store it in a variable operator
  prompt 'What type of operation would you like to perform? Enter one + - * /'

  operator = ''
  loop do
    operator = gets.chomp
    if %w(+ - * /).include?(operator)
      break
    else
      prompt("Must choose + - * /")
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."


  # Calculate the result depending on the users operator input
  result = case operator
           when '+' then num1 + num2
           when '-' then num1 - num2
           when '*' then num1 * num2
           when '/' then num1.to_f / num2
           else
             prompt 'Incorrect operator. Use one of + - * / only'
             return
           end

  # Print the result
  prompt "#{num1} #{operator} #{num2} = #{result}"

  prompt 'Do you want to perform another calculation? (Y/N)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thank you for using the calculator. Goodbye!'
