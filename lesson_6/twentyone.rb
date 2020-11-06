SECS = 3
SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
  'King', 'Ace']
CARD_VALUES = { '2' => [2], '3' => [3], '4' => [4], '5' => [5], '6' => [6],
                '7' => [7], '8' => [8], '9' => [9], '10' => [10],
                'Jack' => [10], 'Queen' => [10], 'King' => [10],
                'Ace' => [1, 11]
}

# Visual representation as a reminder. TODO - delete this at the end
DECK = { 
  'Spades' =>   ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Hearts' =>   ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Clubs' =>    ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Diamonds' => ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace']
}

def clear_screen
  system 'clear'
  system 'cls'
end

def prompt(msg)
  puts "=> #{msg}"
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
    'dealer' => [draw_card(deck), draw_card(deck)]
  }
end

def joinand(arr, delim=', ', conj='and')
  if arr.size == 2
    "#{arr.first} #{conj} #{arr.last}"
  else
    last_item = arr.pop
    arr.join(delim) + delim + conj + ' ' + last_item.to_s
  end
end

def player_hand(hands) # TODO make generic for either person
  joinand(hands['player'].map { |arr| arr[1] })
end

def display_cards(hands) # TODO reuse this for showing hands at the end
  clear_screen
  puts "Dealer has: #{hands['dealer'][0][1]} and unknown"
  puts "You have: #{player_hand(hands)}"
end

def card_value(card)
  if card == 'ace'
    CARD_VALUES[card][0]
  else
    CARD_VALUES[card]
  end
end

def hand_total(hands, person)
  hands[person].map { |card_arr| card_value(card_arr[1]) }.flatten.sum
end

def busted?(hands, person)
  hand_total(hands, person) > 21
end

def hit(deck, hands, person)
  hands[person] << draw_card(deck)
end

def player_turn(deck, hands)
  loop do
    prompt 'hit or stay?'
    answer = gets.chomp.downcase
    break if answer == 'stay' || busted?(hands, 'player')
    
    if answer == 'hit'
      hit(deck, hands, 'player')
      break if busted?(hands, 'player')
    else
      puts "Not sure what you mean..."
    end

    display_cards(hands)
  end

  puts "You busted" if busted?(hands, 'player') 
  puts ""
end

def dealer_turn(deck, hands)
  counter = 0
  loop do
    if hand_total(hands, 'dealer') < 17
      hit(deck, hands, 'dealer')
      case counter
      when 0 then puts "Dealer hits"
      else puts "Dealer hits again"
      end
      sleep SECS
    end
    break if hand_total(hands, 'dealer') >= 17 || busted?(hands, 'dealer')
  end
  
  if busted?(hands, 'dealer')
    puts 'Dealer busted' 
  else
    puts 'Dealer stayed'
    puts 'Calculating winner...'
  end
  sleep SECS
end

def determine_winner(hands)
  if busted?(hands, 'player')
    'dealer'
  elsif busted?(hands, 'dealer')
    'player'
  else
    case hand_total(hands, 'player') <=> hand_total(hands, 'dealer')
    when 1 then 'player'
    when -1 then 'dealer'
    when 0 then 'tie'
    end
  end
end

def display_result(winner, hands)
  clear_screen
  puts "Final score:"
  puts "Dealer had #{hand_total(hands, 'dealer')}"
  puts "You had #{hand_total(hands, 'player')}"
  puts ""
  case winner
  when 'player' then puts "That means you are the winner! Congrats!"
  when 'dealer' then puts "That means the dealer won. Bummer."
  when 'tie' then puts "That means you tied. Meh."
  end
end

##### GAME STARTS HERE #####

#TODO: Welcome User method

deck = initialize_deck
hands = deal_hands(deck)

display_cards(hands)
player_turn(deck, hands)

dealer_turn(deck, hands) unless busted?(hands, 'player')

winner = determine_winner(hands)

display_result(winner, hands)

# TODO: Offer to let them play again and loop

# TODO: If not playing again, goodbye method

=begin
[X] Initialize deck 
[X] Deal cards to player and dealer
[X] Player turn: hit or stay
  [X]- repeat until bust or "stay"
[ ] If player bust, dealer wins.
[ ] Dealer turn: hit or stay
  [ ] repeat until total >= 17
[ ] If dealer bust, player wins.
[ ] Compare cards and declare winner.
=end