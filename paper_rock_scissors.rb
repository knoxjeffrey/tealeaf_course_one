class String
  def valid_choice?
      if ['p', 'r', 's'].include?(self)
        true
      else
        print_string "Enter a valid choice. Please try again"
      end
  end
  
  def valid_decision?
    if ['y', 'n'].include?(self)
      true
    else
      print_string "You must enter Y or N. Please try again"
    end
  end
end

def print_string(text)
  puts "\n*** #{text} ***"
end

def chomp_it
  gets.chomp
end

def outcome(player, computer)
  case
    when WINNING_COMBO[player] == computer then "You win!"
    when WINNING_COMBO[computer] == player then "You lose"
    else "It's a tie"
  end
end

def paper_rock_scissor
  print_string "Play Paper Rock Scissors!"

  begin
  print_string "Choose one: P/R/S"
  choice = chomp_it
  end while !choice.downcase.valid_choice?

  computer_pick = CHOICES.values.sample
  player_pick = CHOICES[choice.downcase.to_sym]
  print_string "You picked #{player_pick} and computer picked #{computer_pick}"

  puts outcome(player_pick, computer_pick)
end

CHOICES = { p: 'Paper', r: 'Rock', s: 'Scissors' }
WINNING_COMBO = { 'Paper' => 'Rock', 'Rock' => 'Scissors', 'Scissors' => 'Paper' }

begin
  paper_rock_scissor
  
  begin
    print_string "Would you like to play again?: Y or N"
    decision = chomp_it
  end while !decision.downcase.valid_decision?
  
end while decision.downcase == 'y'