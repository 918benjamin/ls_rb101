# require 'pry'
# require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
MAX_WINS = 5

def clear_screen
  system 'clear'
  system 'cls'
end

def prompt(msg)
  puts "=> #{msg}"
end

def welcome_user
  prompt "Welcome to Tic Tac Toe!"
  prompt "The first player to #{MAX_WINS} wins game!"
end

def joinor(arr, delim=', ', conj='or')
  if arr.size < 2
    arr.join(delim)
  else
    last_item = arr.pop
    arr.join(delim) + delim + conj + ' ' + last_item.to_s
  end
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def immediate_threat?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count(PLAYER_MARKER) == 2
  end
  false
end

def defensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      line.each { |square| return square if brd[square] == ' ' }
    end
  end
end

def win_chance?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count(COMPUTER_MARKER) == 2
  end
  false
end

def offensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      line.each { |square| return square if brd[square] == ' ' }
    end
  end
end

def computer_places_piece!(brd)
  if
    win_chance?(brd) && brd[offensive_move(brd)] == ' '
    square = offensive_move(brd)
  elsif immediate_threat?(brd) && brd[defensive_move(brd)] == ' '
    square = defensive_move(brd)
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score(scores, winner)
  scores[winner] += 1
end

def determine_grand_winner(scores)
  if scores["Player"] > scores['Computer']
    'Player'
  elsif scores["Computer"] > scores['Player']
    'Computer'
  else
    'Tie'
  end
end

def declare_grand_winner(scores)
  puts "Final score:"
  puts "You won #{scores['Player']} games"
  puts "Computer won #{scores['Computer']} games"
  case determine_grand_winner(scores)
  when 'Player'
    puts "That means you are the grand winner! Congrats!"
  when 'Computer'
    puts "That means the computer is the grand winner. Bummer!"
  when 'Tie'
    puts "That's a tie! Better play again to see who is really the best."
  end
end

### GAME PLAY STARTS HERE ###
loop do
  scores = {"Player" => 0, "Computer" => 0}
  games = 1

  loop do
    board = initialize_board

    loop do
      clear_screen
      puts "Game ##{games}"
      display_board(board)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end
    
    clear_screen
    display_board(board)

    if someone_won?(board)
      prompt("#{detect_winner(board)} won!")
      update_score(scores, detect_winner(board))
    else
      prompt "It's a tie!"
    end

    games += 1

    break if scores["Player"] == MAX_WINS || scores["Computer"] == MAX_WINS

    prompt "Hit enter to continue to game ##{games} or 'quit' to stop."
    next_game = gets.chomp.downcase
    break if next_game.start_with?('q')
  end

  declare_grand_winner(scores)

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye."
