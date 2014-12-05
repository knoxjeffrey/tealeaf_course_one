def display_grid(game_inputs)
  puts "
     |     |
  #{game_inputs[1]}  |  #{game_inputs[2]}  |  #{game_inputs[3]}
     |     |
-----+-----+-----
     |     |
  #{game_inputs[4]}  |  #{game_inputs[5]}  |  #{game_inputs[6]}
     |     |
-----+-----+-----
     |     |
  #{game_inputs[7]}  |  #{game_inputs[8]}  |  #{game_inputs[9]}
     |     |     "
end

def the_empty_positions(current_game_inputs)
  current_game_inputs.select { |k,v| v == ' ' }.keys
end

def check_valid_entry(number_selected, current_game_inputs)
  if !the_empty_positions(current_game_inputs).include?(number_selected.to_i)
    puts "Invalid choice or that position is already taken.  Please try again."
  else
    true
  end
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

def game_over?(current_game_inputs, players_moves, computer_moves)
  if a_winning_combo?(players_moves)
    puts "Player won!"
    true
  elsif a_winning_combo?(computer_moves)
    puts "Computer won!"
    true
  elsif the_empty_positions(current_game_inputs).empty?
    puts "It's a tie"
    true
  end
end

def clever_computer_move(current_game_inputs, current_player_moves,current_computer_moves)
  answer_found = false
  result = ' '
  
  if attack_and_defend_moves(current_game_inputs, current_computer_moves) != ' ' && !answer_found
    result = attack_and_defend_moves(current_game_inputs, current_computer_moves)
    answer_found = true
  elsif attack_and_defend_moves(current_game_inputs, current_player_moves) != ' ' && !answer_found
    result = attack_and_defend_moves(current_game_inputs, current_player_moves)
    answer_found = true
  elsif !answer_found
    result = the_empty_positions(current_game_inputs).sample
  end
  result
end

def attack_and_defend_moves(current_game_inputs, current_player_or_computer_moves)
  result = ' '
  WINNING_COMBOS.each do |array|
    computer_matches = array & current_player_or_computer_moves
    
    if computer_matches.size == 2
      answer = array - current_player_or_computer_moves
      value_in_this_space = current_game_inputs.values_at(answer[0])
      if value_in_this_space[0] == " "
        result =  answer[0]
      end
    end
  end
  result
end

def play_tic_tac_toe(current_game_inputs, players_moves, computer_moves) 
  display_grid(current_game_inputs)  
  begin
    puts "Choose a position (from 1 to 9) to place your piece"
    player_choice = gets.chomp
  end while !check_valid_entry(player_choice,current_game_inputs)

  current_game_inputs[player_choice.to_i] = 'x'
  players_moves << player_choice.to_i

  if !a_winning_combo?(players_moves) && !the_empty_positions(current_game_inputs).empty?
    computer_choice = clever_computer_move(current_game_inputs, players_moves,computer_moves)
    current_game_inputs[computer_choice] = 'o'
    computer_moves << computer_choice
  end

  puts `clear`

  display_grid(current_game_inputs)
end

WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]]
game_inputs = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
player_moves_made = []
computer_moves_made =[]

begin
  puts `clear`
  play_tic_tac_toe(game_inputs, player_moves_made, computer_moves_made) 
end while !game_over?(game_inputs, player_moves_made, computer_moves_made)