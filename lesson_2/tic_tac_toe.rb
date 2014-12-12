require 'pry'
require 'active_support'
require 'active_support/core_ext/object/blank'

module NumberInput
  def self.check_number_chosen(number_selected, empty_grid_positions)
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
  
  def fill_grid_position(board_position, marker)
    game_inputs[board_position] = marker
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
  
  #use attack_and_defend_moves to check if the computer can make a winning move or stop the player making a winning move. 
  #If neither of these then just a random move
  def find_a_clever_move(current_game_inputs, current_player_moves, empty_positions)
    #blank? is used to if the returned result is ' '
    if !attack_and_defend_moves(current_game_inputs, moves_made).blank?
      return attack_and_defend_moves(current_game_inputs, moves_made)
    elsif !attack_and_defend_moves(current_game_inputs, current_player_moves).blank?
      return attack_and_defend_moves(current_game_inputs, current_player_moves)
    else
      return empty_positions.sample
    end
  end
  
  private
  
  def attack_and_defend_moves(current_game_inputs, current_player_or_computer_moves)
    result = ' '
    TicTacToe::WINNING_COMBOS.each do |array|
      #for each winning combo we check to see if the player/computer has any matches and all the matches are returned as an array
      computer_matches = array & current_player_or_computer_moves
      
      #if there are 2 matches against the winning combo then getting 3 in a row is possible
      if computer_matches.size == 2
        #result returns the winning or defensive move
        result = fill_space_to_make_three_in_a_row(array, current_game_inputs, current_player_or_computer_moves)
      end
      
    end
    #if there are no matches then result will remain at ' '
    result
  end
  
  def fill_space_to_make_three_in_a_row(winning_combo_array, current_game_inputs, array_of_player)
    #answer is an array of the one number in the winning_combo array that isn't in the player/computer array. This is the 
    #winning/defensive move to make if the space is free
    answer = winning_combo_array - array_of_player
    #check game inputs to see what is is the grid position given by answer
    value_in_this_space = current_game_inputs.values_at(answer[0])
    
    #if the space is empty then return that space as being playable and if not then return ' '
    if value_in_this_space[0] == " "
      return answer[0]
    else
      return ' '
    end
  end

  
end

class GameFlow
  include TextFormat
  
  attr_reader :game, :player, :computer
  
  def initialize
    @game = TicTacToe.new
    @player = Player.new('Jeff', 'X')
    @computer = Computer.new('Kryton', 'O')
  end
  
  def play
    begin
      puts `clear`
      TextFormat.print_string "You are playing Tic Tac Toe against #{computer.name}"
      game.display_grid
    
      begin
        TextFormat.print_string "Choose a position (from 1 to 9) to place your piece"
        player_choice = TextFormat.chomp_it
        list_of_empty_grid_positions = game.return_empty_positions
      end while !NumberInput.check_number_chosen(player_choice, list_of_empty_grid_positions)
      
      game.fill_grid_position(player_choice.to_i, player.marker)
      player.make_game_move(player_choice.to_i)

      if !game.a_winning_combo?(player.moves_made) && !game.return_empty_positions.empty?
        computer_choice = computer.find_a_clever_move(game.game_inputs, player.moves_made, game.return_empty_positions)
        game.fill_grid_position(computer_choice.to_i, computer.marker)
        computer.make_game_move(computer_choice)
      end
    
      puts `clear`

      game.display_grid
    end while !game_results 
  end
  
  def game_results
    if game.a_winning_combo?(player.moves_made)
      puts "Well done #{player.name}, you won!"
      true
    elsif game.a_winning_combo?(computer.moves_made)
      puts "Sorry #{player.name}, #{computer.name} has won"
      true
    elsif game.return_empty_positions.empty?
      puts "It's a tie, try again #{player.name}"
      true
    end
  end

end

GameFlow.new.play