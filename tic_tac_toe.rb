def the_empty_positions
  $game_inputs.select { |k,v| v == ' ' }.keys
end

def check_valid_entry(number_selected)
  if !the_empty_positions.include?(number_selected.to_i)
    puts "Invalid choice or that position is already taken.  Please try again."
  else
    true
  end
end

def display_grid
  puts "
     |     |
  #{$game_inputs[1]}  |  #{$game_inputs[2]}  |  #{$game_inputs[3]}
     |     |
-----+-----+-----
     |     |
  #{$game_inputs[4]}  |  #{$game_inputs[5]}  |  #{$game_inputs[6]}
     |     |
-----+-----+-----
     |     |
  #{$game_inputs[7]}  |  #{$game_inputs[8]}  |  #{$game_inputs[9]}
     |     |     "
end

def a_winning_combo?(player_or_computer_array)
  answer = false
  sorted_array = player_or_computer_array.sort
  WINNING_COMBOS.each do |array|
    if sorted_array.combination(3).to_a.include?(array)
      answer = true
    end
  end
  answer
end

def game_over?
  if a_winning_combo?($player_moves_made)
    puts "Player won!"
    true
  elsif a_winning_combo?($computer_moves_made)
    puts "Computer won!"
    true
  elsif the_empty_positions.empty?
    puts "It's a tie"
    true
  end
end

def play_tic_tac_toe 
  display_grid   
  begin
    puts "Choose a position (from 1 to 9) to place your piece"
    player_choice = gets.chomp
  end while !check_valid_entry(player_choice)

  $game_inputs[player_choice.to_i] = 'x'
  $player_moves_made << player_choice.to_i

  if !a_winning_combo?($player_moves_made) && !the_empty_positions.empty?
    computer_choice = the_empty_positions.sample
    $game_inputs[computer_choice] = 'o'
    $computer_moves_made << computer_choice
  end

  puts `clear`

  display_grid
end

WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]]
$game_inputs = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
$player_moves_made = []
$computer_moves_made =[]

begin
  puts `clear`
  play_tic_tac_toe 
end while !game_over?