class String
  def valid_choice?
      if ['P', 'R', 'S'].include?(self)
        true
      else
        print_string "Enter a valid choice. Please try again"
      end
  end
  
  def valid_decision?
    if ['Y', 'N'].include?(self)
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

def computer_selection
  computer_choices = ['Paper', 'Rock', 'Scissors']
  computer_choices.sample
end

def outcome(player, computer)
  winning_combo = { 'Paper' => 'Rock', 'Rock' => 'Scissors', 'Scissors' => 'Paper' }
  case
    when winning_combo[player] == computer then "You win!"
    when winning_combo[computer] == player then "You lose"
    else "It's a tie"
  end
end

def paper_rock_scissor
  player_choices = { P: 'Paper', R: 'Rock', S: 'Scissors' }

  print_string "Play Paper Rock Scissors!"

  begin
  print_string "Choose one: P/R/S"
  game = chomp_it
  end while !game.valid_choice?

  computer_pick = computer_selection
  player_pick = player_choices[game.to_sym]
  print_string "You picked #{player_pick} and computer picked #{computer_pick}"

  puts outcome(player_pick, computer_pick)
end

begin
  paper_rock_scissor
  
  begin
    print_string "Would you like to play again?: Y or N"
    decision = chomp_it
  end while !decision.valid_decision?
  
end while decision == 'Y'