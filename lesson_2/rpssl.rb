# --- Constants --- #
VALID_CHOICES = %w(rock paper scissors spock lizard)

# --- Method Definitions --- #
def clear_screen
  system 'clear' # Linux / Mac
  system 'cls' # Windows
end

def prompt(message)
  puts("=> #{message}")
end

def print_welcome
  prompt("Welcome to this Rock Paper Scissors Spock Lizard game")
end

def get_choice
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    input = gets.chomp

    choice = VALID_CHOICES.select { |element| element.start_with?(input) }
    if choice.size == 1
      return choice[0]
    elsif choice.size == 2
      prompt("That's not a valid choice. For scissors or spock type sc or sp")
    else
      prompt("That's not a valid choice.")
    end
  end
end

def abbrev_choice(choice)
  # You give the first letter or 2 letters of a choice
  # If one of the VALID_CHOICES starts with that letter(s), return that element
  # Otherwise, return the invalid choice prompt
end

# def win?(first, second)
#   (first == 'rock' && second == 'scissors') ||
#     (first == 'paper' && second == 'rock') ||
#     (first == 'scissors' && second == 'paper') ||
#     (first == 'rock' && second == 'lizard') ||
#     (first == 'lizard' && second == 'spock') ||
#     (first == 'spock' && second == 'scissors') ||
#     (first == 'scissors' && second == 'lizard') ||
#     (first == 'lizard' && second == 'paper') ||
#     (first == 'paper' && second == 'spock')
# end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'spock' || second == 'paper')) ||
    (first == 'spock' && (second == 'scissors' || second == 'rock'))
end

def display_results(player, computer)
  prompt("You chose: #{player}. Computer chose: #{computer}.")
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won!')
  else
    prompt("It's a tie!")
  end
end

def play_again?
  prompt("Do you want to play again?")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def print_bye
  prompt("Thank you for playing. Goodbye!")
end

# --- Game Start --- #
clear_screen
print_welcome

loop do
  choice = get_choice
  computer_choice = VALID_CHOICES.sample

  display_results(choice, computer_choice)

  break unless play_again?

  clear_screen
end

clear_screen
print_bye
