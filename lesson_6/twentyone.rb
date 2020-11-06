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
  puts "Welcome to Twenty-One!"
  puts "Be closest to 21 without going over (bust) and you win!"
  puts ""
  prompt "Press enter to start"
  gets.chomp
end

def say_goodbye
  clear_screen
  puts "Thanks for playing Twenty-One! Goodbye."
end

def initialize_deck
  SUITS.each_with_object({}) do |suit, hsh|
    hsh[suit] = CARDS.each_with_object([]) do |card, arr|
      arr << card
    end
  end
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

def deal_hands(deck) # TODO: Is it unfair to deal two at once to either player?
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

def join_hand(hands, person) # TODO make generic for either person
  joinand(hands[person].map { |arr| arr[1] })
end

def display_cards(hands) # TODO reuse this for showing hands at the end
  clear_screen
  puts "Dealer has: #{hands['dealer'][0][1]} and unknown"
  puts "You have: #{join_hand(hands, 'player')}"
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
  hand_value > 21
end

def hit(deck, hands, person)
  hands[person] << draw_card(deck)
end

def player_turn(deck, hands)
  loop do
    prompt 'hit or stay?'
    answer = gets.chomp.downcase
    if answer == 'stay' || busted?(hand_total(hands, 'player'))
      break
    elsif answer == 'hit'
      hit(deck, hands, 'player')
      break if busted?(hand_total(hands, 'player'))
    else
      puts "Not sure what you mean..."
      sleep SECS
    end

    display_cards(hands)
  end

  display_player_turn_result(hands)
end

def display_player_turn_result(hands)
  if busted?(hand_total(hands, 'player'))
    puts 'You busted'
  else
    puts "You stayed with a total of #{hand_total(hands, 'player')}"
  end
  puts ""
end

def display_dealer_turn_result(hands)
  if busted?(hand_total(hands, 'dealer'))
    puts 'Dealer busted'
  else
    puts 'Dealer stayed'
  end
  puts ""
  sleep SECS
end

def display_dealer_action(counter)
  case counter
  when 0 then puts "Dealer hits"
  else puts "Dealer hits again"
  end
  sleep SECS
end

def dealer_turn(deck, hands)
  counter = 0
  loop do
    if hand_total(hands, 'dealer') < 17
      hit(deck, hands, 'dealer')
      display_dealer_action(counter)
    end
    break if hand_total(hands, 'dealer') >= 17 ||
             busted?(hand_total(hands, 'dealer'))
  end

  display_dealer_turn_result(hands)
end

def determine_winner(hands)
  if busted?(hand_total(hands, 'player'))
    'dealer'
  elsif busted?(hand_total(hands, 'dealer'))
    'player'
  else
    case hand_total(hands, 'player') <=> hand_total(hands, 'dealer')
    when 1 then 'player'
    when -1 then 'dealer'
    when 0 then 'tie'
    end
  end
end

def display_final_score(hands)
  puts "Final score:"
  puts "Dealer got #{hand_total(hands, 'dealer')} "\
       "(#{join_hand(hands, 'dealer')})"
  puts "You got #{hand_total(hands, 'player')} "\
       "(#{join_hand(hands, 'player')})"
  puts ""
end

def display_result(winner, hands)
  display_final_score(hands)

  case winner
  when 'player' then puts "That means you are the winner! Congrats!"
  when 'dealer' then puts "That means the dealer won. Bummer."
  when 'tie' then puts "That means you tied. Meh."
  end
end

def play_again?
  answer = ""
  loop do
    prompt "Play again? (Y)es or (N)o"
    answer = gets.chomp.downcase
    break if ['y', 'n', 'no', 'yes'].include?(answer)
    prompt "Not sure what you meant there..."
  end
  answer.downcase.start_with?('y')
end

##### GAME STARTS HERE #####

welcome_user

loop do
  deck = initialize_deck
  hands = deal_hands(deck)

  display_cards(hands)
  player_turn(deck, hands)

  dealer_turn(deck, hands) unless busted?(hand_total(hands, 'player'))

  winner = determine_winner(hands)

  display_result(winner, hands)

  break unless play_again?
end

say_goodbye
