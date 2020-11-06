SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
  'King', 'Ace']
CARD_VALUES = { '2' => [2], '3' => [3], '4' => [4], '5' => [5], '6' => [6],
                '7' => [7], '8' => [8], '9' => [9], '10' => [10],
                'Jack' => [10], 'Queen' => [10], 'King' => [10],
                'Ace' => [1] #TODO - add 11 back to ace
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

def player_hand(hands)
  joinand(hands['player'].map { |arr| arr[1] })
end

def display_cards(hands)
  puts "Dealer has: #{hands['dealer'][0][1]} and unknown"
  puts "You have: #{player_hand(hands)}"
end

def card_value(card)
  CARD_VALUES[card]
end

def hand_total(hands, person)
  hands[person].map { |card_arr| card_value(card_arr[1]) }.flatten.sum
end

def busted?(hands, person)
  hand_total(hands, person) > 21
end

def hit(deck, hands)
  hands['player'] << draw_card(deck)
end

def player_turn(deck, hands)
  loop do
    prompt 'hit or stay?'
    answer = gets.chomp
    break if answer == 'stay' || busted?(hands, 'player')
    
    if answer == 'hit'
      hit(deck, hands)
      break if busted?(hands, 'player')
    else
      puts "Not sure what you mean..."
    end
    display_cards(hands)
  end
end

deck = initialize_deck
hands = deal_hands(deck)
display_cards(hands)

player_turn(deck, hands)

puts "Busted! Bummer" if busted?(hands, 'player')

# puts ''
# p deck
# puts ''
# p hands
# puts ''
# p deck

=begin
[X] Initialize deck 
[X] Deal cards to player and dealer
[ ] Player turn: hit or stay
  [ ]- repeat until bust or "stay"
[ ] If player bust, dealer wins.
[ ] Dealer turn: hit or stay
  [ ] repeat until total >= 17
[ ] If dealer bust, player wins.
[ ] Compare cards and declare winner.
=end