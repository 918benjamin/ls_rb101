# Figure out a data structure to contain the "deck" and the "player's cards"
# and "dealer's cards". Maybe a hash? An array? A nested array? Your decision
# will have consequences throughout your code, but don't be afraid of choosing
# the wrong one. Play around with an idea, and see how far you can push it.
# If it doesn't work, back out of it.

hands = { player: [], dealer: [] }

card_values = { '2' => [2], '3' => [3], '4' => [4], '5' => [5], '6' => [6],
                '7' => [7], '8' => [8], '9' => [9], '10' => [10],
                'Jack' => [10], 'Queen' => [10], 'King' => [10],
                'Ace' => [1, 11]
}

deck = { 
  'Spade' =>   ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Heart' =>   ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Club' =>    ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace'],
  'Diamond' => ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen',
                'King', 'Ace']
}