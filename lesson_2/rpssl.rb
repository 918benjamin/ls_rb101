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
  puts "\n"
end

def print_game_number(games)
  prompt("Game #{games}")
end

def print_scores(player_score, computer_score)
  prompt("Your score: #{player_score}. Computer's score: #{computer_score}")
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

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'spock' || second == 'paper')) ||
    (first == 'spock' && (second == 'scissors' || second == 'rock'))
end

def calculate_results(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'tie'
  end
end

def display_results(player, computer, winner)
  prompt("You chose: #{player}. Computer chose: #{computer}.")
  case winner
  when 'player' then prompt('You won!')
  when 'computer' then prompt('Computer won!')
  when 'tie' then prompt("It's a tie!")
  end
end

def grand_winner_chosen?(player_score, computer_score)
  player_score == 5 || computer_score == 5
end

def print_grand_winner(player_score)
  if player_score == 5
    prompt("You are the grand winner! Congrats")
  else
    prompt("Sorry, the computer is the grand winner this time.")
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
  # --- Initialize game count and score --- #
  games = 1
  player_score = 0
  computer_score = 0

  # --- Main Game (Until someone scores 5) --- #
  loop do
    print_game_number(games)

    choice = get_choice
    computer_choice = VALID_CHOICES.sample

    winner = calculate_results(choice, computer_choice)
    display_results(choice, computer_choice, winner)

    case winner
    when 'player' then player_score += 1
    when 'computer' then computer_score += 1
    end
    print_scores(player_score, computer_score)

    break if grand_winner_chosen?(player_score, computer_score)
    
    puts "\n"
    games += 1
  end
  puts "\n"
  print_grand_winner(player_score)

  break unless play_again?
  clear_screen
end

clear_screen
print_bye
