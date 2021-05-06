#!/usr/bin/ruby

level = 4
digits = 6
nbTurns = 12
turn = 1
secretCode = ""

for i in 1..level
    secretCode += (rand(digits) + 1).to_s
end

puts ""
puts "Welcome to Mastermind! (Ruby version)"
puts "The code is 4 digits long, chosen among 6 possible digits (1 to 6)"
puts "Can you find it in less than 12 turns?"
puts ""
# puts "DEBUG: " + secretCode
# puts ""

while turn < nbTurns do
    sCode = secretCode.dup
    hit = 0
    miss = 0

    puts "Turn #{ turn } - Your guess:"
    play = gets

    if play.length != 5 then
        puts "\nYou lose!\nAnswer was #{ secretCode }"
        exit
    end

    play.chomp.each_char.with_index do |c, i|
        if c == sCode[i] then
            hit += 1
            sCode[i] = 'X'
            play[i] = '#'
        end
    end

    play.chomp.each_char.with_index do |c, i|
        if sCode.include?(c) then
            miss += 1
            play[i] = '*'
        end
    end

    if hit == level then
        puts ""
        puts "You win! \\o/"
        puts
        exit
    end

    puts "# Right: #{ hit } - * Miss: #{ miss }"

    # Comment next block to disable hints
    play.chomp.each_char.with_index do |c, i|
        if c.match(/[[:digit:]]/) then
            play[i] = 'x'
        end
    end
    puts "Hint: #{ play } (#: Right, *: Miss, x: Wrong)"
    puts ""

    turn += 1
end

puts "\nYou lose!\nAnswer was #{ secretCode }"
