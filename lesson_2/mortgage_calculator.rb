# Refactoring todos:
# (x) Create a prompt method
# (x) Set up a configuration file for the messages, yaml format
# (x) Validate loan amount as a proper integer > 0
# (X) Validate apr as the correct format > 0
# (X) Validate loan duration as a proper integer > 0
# ( ) Check Ruby style guide max line length and adjust any culprits
# ( ) Check for edge cases/user input not covered

# Edges not covered
# Non-integer loan amounts (seems unlikely to include cents on a mortgage)

# Edges covered
# Including the % sign on APR
# Wrong APR input format (.05 instead of 5)

require 'yaml'

MESSAGE = YAML.load_file('mortgage_calculator_messages.yml')
# puts MESSAGE.inspect

# Method definitions
def prompt(text)
  puts "=> #{text}"
end

def valid_loan?(num)
  num.to_i.to_s == num && num.to_i > 0
end

def valid_apr?(num)
  # Is the APR input an integer > 0?
  if num.to_i.to_s == num && num.to_i > 0
    true
  # Is the APR input a float that looks suspect (converted perhaps)?
  elsif num.to_f.to_s == num && num.to_f < 1
    low_apr(num)
  # Probably a float, true only if valid and > 0
  else
    num.to_f.to_s == num && num.to_f > 0
  end
end

def low_apr(num)
  prompt(MESSAGE['low_apr'])
  prompt("Your APR is #{num}%? (Confirm Y/N)")
  response = gets.chomp.downcase
  if response.split('').first == 'y'
    num.to_f.to_s == num && num.to_f > 0
  else
    false
  end
end

# Welcome the user to the calculator
prompt(MESSAGE['welcome'])

# Get three pieces of input from the user: loan amount, APR, loan duration
loan_amount = ''
loop do
  prompt(MESSAGE['get_loan_amount'])
  loan_amount = gets.chomp
  if valid_loan?(loan_amount)
    loan_amount = loan_amount.to_i
    break
  else
    prompt(MESSAGE['invalid_loan'])
  end
end

apr = ''
loop do
  prompt(MESSAGE['get_apr'])
  apr = gets.chomp
  if valid_apr?(apr)
    apr = (apr.to_f) / 100
    break
  else
    prompt(MESSAGE['invalid_apr'])
  end
end

loan_years = ''
loop do
  prompt(MESSAGE['get_duration'])
  loan_years = gets.chomp
  if valid_loan?(loan_years)
    loan_years = loan_years.to_i
    break
  else
    prompt(MESSAGE['invalid_loan_duration'])
  end
end

# Calculate monthly interest rate
monthly_rate = apr / 12

# Calculate loan duration in months
loan_months = loan_years.to_f * 12

# Calculate monthly payment. The formula is:
# monthly_payment = loan_amount *
# (monthly_rate / (1 - (1 + rate)**(loan_duration_months)))
monthly_payment = loan_amount * (monthly_rate / (1 -
                  (1 + monthly_rate)**(-loan_months)))
monthly_payment = monthly_payment.round(2)

monthly_rate = monthly_rate.round(4) * 100

# Print inputs (verify & remind) & the resulting monthly payment
prompt("Loan amount is $#{loan_amount}")
prompt("APR is #{apr * 100}% so the monthly rate is #{monthly_rate}%")
prompt("Loan is for #{loan_years} years or #{loan_months} months")
prompt("Monthly payment is $#{monthly_payment}")
