# Refactoring todos:
# (x) Create a prompt method
# (x) Set up a configuration file for the messages, yaml format
# (x) Validate loan amount as a proper integer > 0
# (X) Validate apr as the correct format > 0
# (X) Validate loan duration as a proper integer > 0
# ( ) Check for edge cases/user input not covered
  # Not covered
    # Non-integer loan amounts (seems unlikely to include cents on a mortgage)
  # Covered
    # Including the % sign on APR
    # Wrong APR input format (.05 instead of 5)
# ( ) Check Ruby style guide max line length and adjust any culprits

require 'yaml'

MESSAGE = YAML.load_file('mortgage_calculator_messages.yml')
# puts MESSAGE.inspect

# Method definitions
def prompt(text)
  puts "=> #{text}"
end

def valid_loan?(num)
  (num.to_i.to_s == num) && (num.to_i > 0)
end

def valid_apr?(num)
  if (num.to_i.to_s == num) && (num.to_i > 0)
    return true
  else
    if (num.to_f.to_s == num) && (num.to_f < 1)
      prompt(MESSAGE['low_apr'])
      prompt("Your APR is #{num}% (Confirm Y/N)")
      response = gets.chomp.downcase
      if response.split('').first == 'y'
        return (num.to_f.to_s == num) && (num.to_f > 0)
      else
        return false
      end
    else
      (num.to_f.to_s == num) && (num.to_f > 0)
    end
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

loan_duration_years = ''
loop do
  prompt(MESSAGE['get_duration'])
  loan_duration_years = gets.chomp
  if valid_loan?(loan_duration_years)
    loan_duration_years = loan_duration_years.to_i
    break
  else
    prompt(MESSAGE['invalid_loan_duration'])
  end
end

# Calculate monthly interest rate
monthly_interest_rate = apr / 12

# Calculate loan duration in months
loan_duration_months = loan_duration_years.to_f * 12

# Calculate monthly payment. The formula is:
# monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + rate)**(loan_duration_months)))
monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))
monthly_payment = monthly_payment.round(2)

# Output a summary of the inputs (for verification and reminder) and the resulting monthly payment
prompt("Loan amount is $#{loan_amount}")
prompt("APR is #{apr * 100}% so monthly interest rate is #{monthly_interest_rate.round(4) * 100}%")
prompt("Loan is for #{loan_duration_years} years or #{loan_duration_months} months")
prompt("Monthly payment is $#{monthly_payment}")
