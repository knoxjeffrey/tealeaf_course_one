def check_valid_number_entered(number_selected)
  if !$grid_slots_available.include?(number_selected.to_i)
    puts "Invalid choice or that position is already taken.  Please try again."
  else $grid_slots_available.include?(number_selected.to_i)
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

def is_a_win_or_tie?
  if $player_winner
    puts "Player won!"
    true
  elsif $computer_winner
    puts "Computer won!"
    true
  elsif $grid_slots_available.empty?
    puts "It's a tie"
    true
  end
end

WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]]
$game_inputs = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
$grid_slots_available = [1, 2, 3, 4, 5, 6, 7, 8, 9]
$player_moves_made = []
$computer_moves_made =[]
$player_winner = false
$computer_winner = false
$ame_over = false

def play_tic_tac_toe 
  display_grid   
  begin
    puts "Choose a position (from 1 to 9) to place your piece"
    player_choice = gets.chomp
  end while !check_valid_number_entered(player_choice)

  $grid_slots_available.delete(player_choice.to_i)
  $game_inputs[player_choice.to_i] = 'x'
  $player_moves_made << player_choice.to_i
  
  sorted_player_array = $player_moves_made.sort
  WINNING_COMBOS.each do |array|
    if sorted_player_array.combination(3).to_a.include?(array)
      $player_winner = true
    end
  end

  if !$player_winner && !$grid_slots_available.empty?
    computer_choice = $grid_slots_available.sample
    $grid_slots_available.delete(computer_choice)
    $game_inputs[computer_choice] = 'o'
    $computer_moves_made << computer_choice
    sorted_computer_array = $computer_moves_made.sort
    WINNING_COMBOS.each do |array|
      if sorted_computer_array.combination(3).to_a.include?(array)
        $computer_winner = true
      end
    end
  end

  puts `clear`

  display_grid
end

begin
  puts `clear`
  play_tic_tac_toe 
end while !is_a_win_or_tie?