# --- Constants --- #
VALID_CHOICES = %w(rock paper scissors spock lizard)
RULES = { 'rock' => ['scissors', 'lizard'],
          'paper' => ['rock', 'spock'],
          'scissors' => ['paper', 'lizard'],
          'spock' => ['rock', 'scissors'],
          'lizard' => ['paper', 'spock'] }
MAX_SCORE = 5

# --- Method Definitions --- #
def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts("=> #{message}")
end

def new_lines
  puts "\r"
  puts "\r"
  puts "\r"
end

def print_welcome
  prompt("Welcome to this Rock Paper Scissors Spock Lizard game")
  prompt("Can you get #{MAX_SCORE} win#{'s' if MAX_SCORE > 1} before me?")
  prompt("We'll see... Let's get started!")
  puts "\r"
  prompt("You can select rock, paper, scissors, spock, or lizard.")
  prompt("Use the full world or 1st letter (2 letters for scissors/spock)")
  prompt("Example: type 'r' to select 'rock'")
  prompt("Exmaple: type 'sc' to select 'scissors'")
  new_lines
end

def print_game_number(games)
  prompt("Game #{games}")
end

def print_scores(scores)
  prompt("Your score: #{scores[:player]}. My score: #{scores[:computer]}")
end

def get_user_move
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    input = gets.chomp.downcase

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

def get_computer_move
  VALID_CHOICES.sample
end

def win?(first, second)
  RULES[first].include?(second)
end

def determine_winner(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'tie'
  end
end

def update_scores(scores, winner)
  scores[winner.to_sym] += 1
end

def display_results(player, computer, winner)
  prompt("You chose: #{player}. I chose: #{computer}.")
  case winner
  when 'player' then prompt('You won!')
  when 'computer' then prompt('I won!')
  when 'tie' then prompt("It's a tie!")
  end
end

def next_game(games)
  games[0] += 1
end

def game_won?(scores)
  scores[:player] == MAX_SCORE || scores[:computer] == MAX_SCORE
end

def print_grand_winner(scores)
  puts "\r"
  if scores[:player] == MAX_SCORE
    prompt("You are the grand winner! Wow, I cannot believe you beat me.")
  else
    prompt("Sorry, I'm the grand winner this time. Better luck next time!")
  end
end

def play_again?
  loop do
    prompt("Do you want to play again? (Y/N)")
    answer = gets.chomp.downcase
    case answer
    when 'y', 'yes' then break true
    when 'n', 'no' then break false
    else puts "I don't understand. Answer yes or no (y or n work too)"
    end
  end
end

def print_bye
  prompt("Thank you for playing. Goodbye!")
end

# --- Game Start --- #
clear_screen
print_welcome

loop do
  # --- Initialize game count and score --- #
  scores = { player: 0, computer: 0, tie: 0 }
  games = [1]

  # --- Main Game (Until someone scores MAX_SCORE) --- #
  loop do
    print_game_number(games[0])

    user_move = get_user_move
    computer_move = get_computer_move

    winner = determine_winner(user_move, computer_move)
    display_results(user_move, computer_move, winner)

    update_scores(scores, winner)
    print_scores(scores)

    break if game_won?(scores)

    next_game(games)
    new_lines
  end

  print_grand_winner(scores)

  break unless play_again?
  clear_screen
end

clear_screen
print_bye
