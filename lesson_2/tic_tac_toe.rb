module NumberInput
  def self.check_valid_entry(number_selected, empty_grid_positions)
    if !empty_grid_positions.include?(number_selected.to_i)
      puts "Invalid choice or that position is already taken. Please try again."
    else
      true
    end
  end
end

module TextFormat
  
  def self.print_string(text)
    puts "\n*** #{text} ***"
  end
  
  def self.chomp_it
    gets.chomp
  end
end

class TicTacToe
  
  attr_accessor :game_inputs
  
  WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]]
  
  def initialize
    @game_inputs = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
  end
  
  def display_grid
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
  
  def return_empty_positions
    game_inputs.select { |k,v| v == ' ' }.keys
  end
  
  def a_winning_combo?(array_combination)
    answer = false
    sorted_array = array_combination.sort
    WINNING_COMBOS.each do |array|
      if sorted_array.combination(3).to_a.include?(array)
        answer = true
      end
    end
    answer
  end
  
end

class Player
  attr_reader :name, :moves_made, :marker
  
  def initialize(name, marker)
    @name = name
    @marker = marker
    @moves_made = []
  end
  
  def make_game_move(number_selection)
    moves_made << number_selection
  end
end

class Computer < Player
  
  def clever_move(current_game_inputs, current_player_moves, empty_positions)
    if attack_and_defend_moves(current_game_inputs, moves_made) != ' '
      return attack_and_defend_moves(current_game_inputs, moves_made)
    elsif attack_and_defend_moves(current_game_inputs, current_player_moves) != ' '
      return attack_and_defend_moves(current_game_inputs, current_player_moves)
    else
      return empty_positions.sample
    end
  end

  def attack_and_defend_moves(current_game_inputs, current_player_or_computer_moves)
    result = ' '
    TicTacToe::WINNING_COMBOS.each do |array|
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
end

class GameFlow
  include TextFormat
  
  attr_reader :ttt, :player, :computer
  
  def initialize
    @ttt = TicTacToe.new
    @player = Player.new('Jeff', 'X')
    @computer = Computer.new('Watson', 'O')
  end
  
  def play
    begin
      puts `clear`
      TextFormat.print_string "You are playing Tic Tac Toe against #{computer.name}"
      ttt.display_grid
    
      begin
        TextFormat.print_string "Choose a position (from 1 to 9) to place your piece"
        player_choice = TextFormat.chomp_it
        list_of_empty_grid_positions = ttt.return_empty_positions
      end while !NumberInput.check_valid_entry(player_choice, list_of_empty_grid_positions)
    
      ttt.game_inputs[player_choice.to_i] = player.marker
      player.make_game_move(player_choice.to_i)
    
      if !ttt.a_winning_combo?(player.moves_made) && !ttt.return_empty_positions.empty?
        computer_choice = computer.clever_move(ttt.game_inputs, player.moves_made, ttt.return_empty_positions)
        ttt.game_inputs[computer_choice] = computer.marker
        computer.make_game_move(computer_choice)
      end
    
      puts `clear`

      ttt.display_grid
    end while !game_results 
  end
  
  def game_results
    if ttt.a_winning_combo?(player.moves_made)
      puts "Well done #{player.name}, you won!"
      true
    elsif ttt.a_winning_combo?(computer.moves_made)
      puts "Sorry #{player.name}, #{computer.name} has won"
      true
    elsif ttt.return_empty_positions.empty?
      puts "It's a tie, try again #{player.name}"
      true
    end
  end

end

GameFlow.new.play