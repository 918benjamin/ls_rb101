# Code from other students, just testing an assumption

INITIAL_MARKER = ' '
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                 [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
FINAL_SCORE = 5
CURRENT_PLAYER = "choose"
scores = { "player" => 0, "computer" => 0 }

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop: disable Metrics/AbcSize
def display_board(brd, scores)
  clear_screen
  puts ""
  puts "   TIC TAC TOE"
  puts "1    |2    |3"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "4    |5    |6"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "7    |8    |9"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  display_score(scores)
end
# rubocop: enable Metrics/AbcSize

def joinor(arr, delimiter= ', ', word='or')
  if arr.length < 3
    arr.join(" #{word} ")
  else
    arr.join(delimiter).insert(-2, "#{word} ")
  end
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def update_board!(brd, marker, square, scores)
  brd[square] = marker
  display_board(brd, scores)
end

def choose_marker(brd, scores)
  marker = ''
  loop do
    prompt "Choose your marker: X or O"
    marker = gets.chomp.upcase
    break if ['X', 'O'].include?(marker)
    display_board(brd, scores)
    prompt "Please enter a valid marker."
  end
  marker
end

def assign_comp_marker(player_marker)
  player_marker == 'X' ? 'O' : 'X'
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def valid_integer?(num)
  num.to_i.to_s == num
end

def choose_current_player
  current_player = ''
  prompt "Who goes first, player or computer?"
    loop do
      current_player = gets.chomp.downcase
      break if ['player', 'computer'].include?(current_player)
      prompt "Please choose 'player' or 'computer' to go first."
    end
  current_player
end

def set_current_player(current_player)
  if CURRENT_PLAYER == "player"
    current_player = "player"
  elsif CURRENT_PLAYER == "computer"
    current_player = "computer"
  elsif CURRENT_PLAYER == "choose"
    current_player = choose_current_player
  end
  current_player
end

def players_turn(brd, player_marker, scores)
  square = ''
  loop do
    prompt "Choose a square. (#{joinor(empty_squares(brd))})"
    square = gets.chomp
    break if empty_squares(brd).include?(square.to_i) && valid_integer?(square)
    display_board(brd, scores)
    prompt "Invalid square, please choose an empty square."
  end
  update_board!(brd, player_marker, square.to_i, scores)
end

def two_in_a_row(brd, marker)
  win_lines = WINNING_LINES.dup
  win_lines.map do |row|
    if row.count { |square| brd[square] == marker } == 2 && at_risk?(brd, row)
      return row.select { |square| square if brd[square] == INITIAL_MARKER }[0]
    end
  end
  false
end

def at_risk?(brd, row)
  brd.values_at(*row).include?(INITIAL_MARKER)
end

def computers_turn(brd, comp_marker, player_marker, scores)
  square = if two_in_a_row(brd, comp_marker)
             two_in_a_row(brd, comp_marker)
           elsif two_in_a_row(brd, player_marker)
             two_in_a_row(brd, player_marker)
           elsif brd[5] == INITIAL_MARKER
             5
           else
             empty_squares(brd).sample
           end
  update_board!(brd, comp_marker, square, scores)
  puts "Computer (#{comp_marker}) played square #{square}."
end

def place_piece(brd, current_player, player_marker, comp_marker, scores)
  if current_player == "player"
    players_turn(brd, player_marker, scores)
  else
    computers_turn(brd, comp_marker, player_marker, scores)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner?(brd, player_marker, comp_marker)
  WINNING_LINES.each do |row|
    return "Player" if row.all? { |num| brd[num] == player_marker }
    return "Computer" if row.all? { |num| brd[num] == comp_marker }
  end
  false
end

def display_round_winner(winner)
  if winner
    puts "#{winner} won this round!"
  else
    puts "It's a Tie!"
  end
end

def update_score!(brd, scores, player_marker, comp_marker)
  winner = winner?(brd, player_marker, comp_marker)
  if winner == "Player"
    scores['player'] += 1
  elsif winner == "Computer"
    scores['computer'] += 1
  end
end

def display_score(scores)
  puts "Player: #{scores['player']} | Computer: #{scores['computer']}"
end

def pause_for_next_round
  prompt "Next round..."
  sleep 3
end

def play_again?
  answer = ''
  loop do
    prompt "Do you want to play again? (y/n)"
    answer = gets.chomp.downcase
    break if ['y', 'n'].include?(answer)
    prompt "Invalid, please enter 'y' or 'n'."
  end
  answer == 'y'
end

def game_over?(scores)
  scores['player'] == FINAL_SCORE || scores['computer'] == FINAL_SCORE
end

def display_game_winner(scores)
  if scores['player'] == FINAL_SCORE
    puts "Congrats! You won the game!"
  elsif scores['computer'] == FINAL_SCORE
    puts "GAME OVER. The computer won this game."
  end
  puts " ~~~~~FINAL SCORE~~~~~"
  display_score(scores)
end

def reset_score!(scores)
  scores['player'] = 0
  scores['computer'] = 0
end

def clear_screen
  system("clear") || system("cls")
end

def display_greeting
  prompt "Welcome! Let's play some Tic Tac Toe!"
  prompt "Get 3 in a row to win a round! First to win 5 rounds wins the game!"
  prompt "Game starting..."
end

def display_goodbye
  prompt "Goodbye, thanks for playing Tic Tac Toe!"
end

# main game
clear_screen
display_greeting
sleep 5

loop do # game loop
  board = initialize_board
  display_board(board, scores)

  player_marker = choose_marker(board, scores)
  comp_marker = assign_comp_marker(player_marker)

  current_player = set_current_player(current_player) # who goes first

  loop do # reset board for new round
    board = initialize_board
    display_board(board, scores)

    loop do # round loop
      place_piece(board, current_player, player_marker, comp_marker, scores)
      current_player = alternate_player(current_player)
      break if winner?(board, player_marker, comp_marker) || board_full?(board)
    end
    update_score!(board, scores, player_marker, comp_marker)

    unless scores.value?(FINAL_SCORE)
      display_round_winner(winner?(board, player_marker, comp_marker))
      pause_for_next_round
    end
    break if game_over?(scores)
  end
  display_game_winner(scores)
  reset_score!(scores)
  break unless play_again?
end

display_goodbye