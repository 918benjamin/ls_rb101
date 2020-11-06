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

deck = initialize_deck
hands = initialize_hands


=begin
1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.
=end