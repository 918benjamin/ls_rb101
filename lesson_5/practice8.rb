# Using the each method, write some code to output all of the vowels
# from the strings.


hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiou'

hsh.each_value do |words|
  words.each do |word|
    word.each_char do |char|
      puts char if vowels.include?(char)
    end
  end
end

# => e, u, i, o, o, u, e, o, e, e, a, o