# Refactoring to dos
# Create a prompt method
# Set up a configuration file for the messages, yaml format
# Check for edge cases
# Validate loan amount as a proper integer > 0
# Validate apr as the correct format > 0
# Validate loan duration as a proper integer > 0


# Get three pieces of input from the user: loan amount, APR, loan duration
puts '=> What is the loan amount in dollars?'
loan_amount = gets.chomp.to_i

puts '=> What is the APR? (in x% format without the %)'
apr = gets.chomp.to_f / 100


puts '=> What is the loan duration in years?'
loan_duration_years = gets.chomp.to_i


# Calculate monthly interest rate
monthly_interest_rate = apr / 12

# Calculate loan duration in months
loan_duration_months = loan_duration_years.to_f * 12

# Calculate monthly payment. The formula is:
# monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + rate)**(loan_duration_months)))
monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))
monthly_payment = monthly_payment.round(2)

puts "=> Loan amount is: $#{loan_amount}"
puts "=> APR is: #{apr * 100}%"
puts "=> Loan is for #{loan_duration_years} years or #{loan_duration_months} months"
puts "=> Monthly interest rate is: #{monthly_interest_rate.round(4) * 100}%"
puts "=> Monthly payment is $#{monthly_payment}"