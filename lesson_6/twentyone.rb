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

def initialize_hands
  { 'player' => [], 'dealer' => [] }
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

def display_cards(hands)
  puts "Dealer has: #{hands['dealer'][0][1]} and unknown"
  puts "You have: #{hands['player'][0][1]} and #{hands['player'][1][1]}"
end

deck = initialize_deck
hands = deal_hands(deck)
display_cards(hands)


puts ''
p deck
puts ''
p hands
puts ''
p deck

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