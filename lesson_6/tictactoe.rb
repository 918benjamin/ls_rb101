# require 'pry'
# require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
MAX_WINS = 5
FIRST_MOVE = 'choose'

def clear_screen
  system 'clear'
  system 'cls'
end

def prompt(msg)
  puts "=> #{msg}"
end

def welcome_user
  clear_screen
  puts "Welcome to Tic Tac Toe!"
  puts "Get 3 in a row before your opponent does to win a game."
  puts "The first one to win #{MAX_WINS} games wins it all!"
  puts ""
  prompt "Press enter to start"
  gets.chomp
end

def say_goodbye
  clear_screen
  puts "Thanks for playing Tic Tac Toe! Goodbye."
end

def joinor(arr, delim=', ', conj='or')
  if arr.size < 2
    arr.join(delim)
  else
    last_item = arr.pop
    arr.join(delim) + delim + conj + ' ' + last_item.to_s
  end
end

def decide_player_order
  case FIRST_MOVE
  when 'player' then ['player', 'computer']
  when 'computer' then ['computer', 'player']
  when 'choose' then choose_first_player
  else print "Invalid constant for FIRST_MOVE"
  end
end

def choose_first_player
  player_one = ''
  player_array = ['player', 'computer']
  loop do
    prompt "Who should go first? Enter 'player' for you or 'computer' for me"
    player_one = gets.chomp
    break if player_one == 'player' || player_one == 'computer'
    prompt "Invalid selection."
  end
  player_array.delete(player_one)
  player_two = player_array.join
  [player_one, player_two]
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, games)
  clear_screen
  puts "Game ##{games}"
  puts "You're playing #{PLAYER_MARKER}. I'm playing #{COMPUTER_MARKER}"
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

def trigger_specific_move?(brd, marker)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count(marker) == 2
  end
  false
end

def ai_move(brd, marker)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2
      line.each { |square| return square if brd[square] == ' ' }
    end
  end
end

def computer_places_piece!(brd)
  square = if trigger_specific_move?(brd, COMPUTER_MARKER) &&
              brd[ai_move(brd, COMPUTER_MARKER)] == ' '
             ai_move(brd, COMPUTER_MARKER)
           elsif trigger_specific_move?(brd, PLAYER_MARKER) &&
                 brd[ai_move(brd, PLAYER_MARKER)] == ' '
             ai_move(brd, PLAYER_MARKER)
           elsif brd[5] == ' '
             5
           else
             empty_squares(brd).sample
           end
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, player)
  case player
  when 'player' then player_places_piece!(brd)
  when 'computer' then computer_places_piece!(brd)
  end
end

def alternate_player(player, player_order)
  if player == player_order[0]
    player_order[1]
  else
    player_order[0]
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'computer'
    end
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def declare_round_winner(brd, scores)
  if someone_won?(brd)
    winner = detect_winner(brd)
    case winner
    when 'player' then prompt("You won this game!")
    when 'computer' then prompt("I won this game!")
    end
    update_score(scores, detect_winner(brd))
  else
    prompt "It's a tie!"
  end
end

def loser_goes_first!(order, brd)
  order.reverse! if detect_winner(brd) == order[0]
end

def quit_early?(games)
  prompt "Hit enter to continue to game ##{games} or 'q' to stop early."
  next_game = gets.chomp.downcase
  next_game.start_with?('q') ? true : false
end

def update_score(scores, winner)
  scores[winner] += 1
end

def determine_grand_winner(scores)
  if scores["player"] > scores['computer']
    'player'
  elsif scores["computer"] > scores['player']
    'computer'
  else
    'tie'
  end
end

def declare_grand_winner(scores)
  clear_screen
  puts "Final score:"
  puts "You won #{scores['player']} game#{scores['player'] == 1 ? '' : 's'}"
  puts "I won #{scores['computer']} game#{scores['computer'] == 1 ? '' : 's'}"
  case determine_grand_winner(scores)
  when 'player'
    puts "That means you are the grand winner! Congrats!"
  when 'computer'
    puts "That means I'm the grand winner. Bummer for you!"
  when 'tie'
    puts "That's a tie! Better play again to see who is really the best."
  end
  puts ""
end

def play_again?
  prompt "Play again? (y for yes, anything else for no)"
  answer = gets.chomp
  answer.downcase.start_with?('y') ? true : false
end

### GAME PLAY STARTS HERE ###
welcome_user

loop do # Multi-game grand winner loop
  scores = { "player" => 0, "computer" => 0 }
  games = 1
  player_order = decide_player_order

  loop do # Single game loop
    board = initialize_board
    current_player = player_order.first

    loop do # Individual move loop
      display_board(board, games)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player, player_order)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, games)

    declare_round_winner(board, scores)

    games += 1

    break if scores["player"] == MAX_WINS ||
      scores["computer"] == MAX_WINS ||
      quit_early?(games)

    loser_goes_first!(player_order, board)
  end

  declare_grand_winner(scores)

  break unless play_again?
end

say_goodbye
