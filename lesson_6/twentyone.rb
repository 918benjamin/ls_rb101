MAX_HAND_VALUE = 21
DEALER_HITS_BELOW = 17
MAX_WINS = 5
SECS = 1
SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
         'King', 'Ace']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10,
                'King' => 10, 'Ace' => 11 }

def clear_screen
  system 'clear'
  system 'cls'
end

def prompt(msg)
  puts "=> #{msg}"
end

def welcome_user
  clear_screen
  puts "Welcome to #{MAX_HAND_VALUE}!"
  puts "Be closest to #{MAX_HAND_VALUE} without going over to win a hand."
  puts "First one to win #{MAX_WINS} hands is the grand winner!"
  puts ""
  puts "hint: The dealer always hits below #{DEALER_HITS_BELOW}"
  puts ""
  prompt "Press enter to start"
  gets.chomp
end

def say_goodbye
  clear_screen
  puts "Thanks for playing #{MAX_HAND_VALUE}! Goodbye."
end

def initialize_deck
  SUITS.each_with_object({}) do |suit, hsh|
    hsh[suit] = CARDS.each_with_object([]) do |card, arr|
      arr << card
    end
  end
end

def initialize_score
  { 'player' => 0, 'dealer' => 0, 'tie' => 0 }
end

def draw_card(deck)
  suit = ''
  loop do
    suit = deck.keys.sample
    break unless deck[suit].empty?
  end
  card = deck[suit].sample
  deck[suit].delete(card)
  [suit, card]
end

def deal_hands(deck)
  { 'player' => [draw_card(deck), draw_card(deck)],
    'dealer' => [draw_card(deck), draw_card(deck)] }
end

def joinand(arr, delim=', ', conj='and')
  if arr.size == 2
    "#{arr.first} #{conj} #{arr.last}"
  else
    last_item = arr.pop
    arr.join(delim) + delim + conj + ' ' + last_item.to_s
  end
end

def join_hand(hands, person)
  joinand(hands[person].map { |arr| arr[1] })
end

def display_cards(hands, rounds)
  clear_screen
  puts "Hand ##{rounds}"
  puts "--------"
  puts ""
  puts "Dealer has: #{hands['dealer'][0][1]} and unknown"
  puts "You have: #{join_hand(hands, 'player')} "\
       "(#{hand_total(hands, 'player')} total)"
  puts ""
end

def card_value(card)
  CARD_VALUES[card]
end

def hand_total(hands, person)
  total = 0
  arr = hands[person].map { |card_arr| card_value(card_arr[1]) }
  total = arr.sum
  loop do
    break unless busted?(total) && arr.include?(11)
    arr.delete_at(arr.find_index(11))
    total -= 10
  end
  total
end

def busted?(hand_value)
  hand_value > MAX_HAND_VALUE
end

def hit(deck, hands, person)
  hands[person] << draw_card(deck)
end

def display_turn_result(person, hand_total)
  if busted?(hand_total)
    puts "#{person == 'player' ? 'You' : 'Dealer'} busted"
  elsif person == 'player'
    puts "You stayed with a total of #{hand_total}"
    puts ""
  else
    puts 'Dealer stayed'
    puts ""
    sleep SECS
  end
end

# rubocop:disable Metrics/MethodLength
def player_turn(deck, hands, rounds)
  player_hand_total = hand_total(hands, 'player')

  loop do
    prompt 'Would you like to hit or stay?'
    answer = gets.chomp.downcase
    case answer
    when 'stay' then break
    when 'hit' then hit(deck, hands, 'player')
    else
      puts "Not sure what you mean..."
      next
    end

    player_hand_total = hand_total(hands, 'player')
    break if busted?(player_hand_total)
    display_cards(hands, rounds)
  end

  display_turn_result('player', player_hand_total)
end
# rubocop:enable Metrics/MethodLength

def display_dealer_action(counter)
  case counter
  when 0 then puts "Dealer hits"
  else puts "Dealer hits again"
  end
  sleep SECS
end

def dealer_turn(deck, hands)
  counter = 0
  dealer_hand_total = hand_total(hands, 'dealer')
  loop do
    if dealer_hand_total < DEALER_HITS_BELOW
      hit(deck, hands, 'dealer')
      dealer_hand_total = hand_total(hands, 'dealer')
      display_dealer_action(counter)
    end
    break if dealer_hand_total >= DEALER_HITS_BELOW ||
             busted?(dealer_hand_total)
  end

  display_turn_result('dealer', dealer_hand_total)
end

def determine_winner(hands)
  player_hand_total = hand_total(hands, 'player')
  dealer_hand_total = hand_total(hands, 'dealer')
  if busted?(player_hand_total)
    'dealer'
  elsif busted?(dealer_hand_total)
    'player'
  else
    case player_hand_total <=> dealer_hand_total
    when 1 then 'player'
    when -1 then 'dealer'
    when 0 then 'tie'
    end
  end
end

def display_round_score(hands)
  sleep SECS
  clear_screen
  puts "Hand results:"
  puts "Dealer got #{hand_total(hands, 'dealer')} "\
       "(#{join_hand(hands, 'dealer')})"
  puts "You got #{hand_total(hands, 'player')} "\
       "(#{join_hand(hands, 'player')})"
  puts ""
end

def display_result(winner, hands)
  display_round_score(hands)

  case winner
  when 'player' then puts "You won this hand. Congrats!"
  when 'dealer' then puts "Dealer won this hand. Bummer."
  when 'tie' then puts "That means you tied. Meh."
  end
  puts ""
end

def update_score(score, winner)
  score[winner] += 1
end

def grand_winner?(score)
  score['player'] == MAX_WINS || score['dealer'] == MAX_WINS
end

def determine_grand_winner(score)
  if score['player'] == score['dealer']
    'tie'
  else
    score['player'] > score['dealer'] ? 'player' : 'dealer'
  end
end

def display_grand_winner(winner, score)
  puts ""
  puts "---------------------"
  puts ""
  puts "GRAND WINNER:"
  case winner
  when 'dealer'
    puts "The dealer won #{score['dealer']} hands so they're the grand winner."
  when 'player'
    puts "You won #{score['player']} hands so you are the grand winner! Woo!"
  when 'tie'
    puts "You and the dealer tied. You should play again to see who is better."
  end
  puts ""
end

def play_again_or_continue?(next_round=true)
  answer = ""
  loop do
    if next_round
      prompt "Continue to the next hand? (Y)es or (N)o"
    else
      prompt "Want to play again? (Y)es or (N)o"
    end
    answer = gets.chomp.downcase
    break if ['y', 'n', 'no', 'yes'].include?(answer)
    puts "Not sure what you meant there..."
    puts ""
  end
  answer.downcase.start_with?('y')
end

##### GAME STARTS HERE #####

welcome_user

loop do
  score = initialize_score
  rounds = 0

  loop do
    deck = initialize_deck
    hands = deal_hands(deck)
    rounds += 1

    display_cards(hands, rounds)
    player_turn(deck, hands, rounds)

    dealer_turn(deck, hands) unless busted?(hand_total(hands, 'player'))

    winner = determine_winner(hands)
    update_score(score, winner)

    display_result(winner, hands)

    break if grand_winner?(score) || !play_again_or_continue?
  end

  grand_winner = determine_grand_winner(score)
  display_grand_winner(grand_winner, score)

  break unless play_again_or_continue?(false)
end
say_goodbye
