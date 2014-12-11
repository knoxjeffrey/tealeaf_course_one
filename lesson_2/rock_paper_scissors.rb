module TextAndInputs
  def self.print_string(text)
    puts "\n*** #{text} ***"
  end

  def self.chomp_it
    gets.chomp
  end

  def self.valid_choice?(choice)
      if ['p', 'r', 's'].include?(choice.downcase)
        true
      else
        print_string "Enter a valid choice. Please try again"
      end
  end

  def self.valid_decision?(the_decision)
    if ['y', 'n'].include?(the_decision.downcase)
      return true
    else
      print_string "You must enter Y or N. Please try again"
    end
  end
end

class RockPaperScissors
  
  CHOICES = { r: 'Rock', p: 'Paper', s: 'Scissors' }
  WINNING_COMBO = { 'Paper' => 'Rock', 'Rock' => 'Scissors', 'Scissors' => 'Paper' }
  
  attr_reader :rock, :paper, :scissors
  
  def initialize
    @rock = 'rock'
    @paper = 'paper'
    @scissors = 'scissors'
  end

  def result(player_hand, computer_hand)
    case
      when WINNING_COMBO[player_hand] == computer_hand then :win
      when WINNING_COMBO[computer_hand] == player_hand then :lose
      else :tie
    end
  end
end

class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def make_choice(selection)
    RockPaperScissors::CHOICES[selection.downcase.to_sym]
  end
end

class Computer < Player
  
  def make_choice
    RockPaperScissors::CHOICES.values.sample
  end
end

class GameFlow
  include TextAndInputs
  
  attr_reader :rps, :player, :computer
  
  def initialize
    @rps = RockPaperScissors.new
    @player = Player.new('Jeff')
    @computer = Computer.new('Watson')
  end
  
  def play
    begin
      puts `clear`
      TextAndInputs.print_string "You are playing Rock Paper Scissors against #{computer.name}"
  
      begin
      TextAndInputs.print_string "Choose one: P/R/S"
      choice = TextAndInputs.chomp_it
      end while !TextAndInputs.valid_choice?(choice)
  
      player_pick = player.make_choice(choice)
      computer_pick = computer.make_choice
  
      TextAndInputs.print_string "#{player.name} picked #{player_pick} and #{computer.name} picked #{computer_pick}"
      case rps.result(player_pick, computer_pick)
      when :win
        TextAndInputs.print_string "Good job #{player.name}, you have won!"
      when :lose
        TextAndInputs.print_string "Sorry #{player.name}, #{computer.name} has won the game."
      when :tie
        TextAndInputs.print_string "It's a tie. Try again #{player.name}."
      end
    
      begin
        TextAndInputs.print_string "Would you like to play again?: Y or N"
        decision = TextAndInputs.chomp_it
      end while !TextAndInputs.valid_decision?(decision)
  
    end while decision.downcase == 'y'
  end
end

GameFlow.new.play