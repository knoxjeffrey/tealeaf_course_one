class String
  def numeric?
    true if Float(self) != nil rescue print_string "You must enter a number. Please try again" 
  end
  
  def valid_operator?
      if ['1', '2', '3', '4', 'Add', 'Subtract', 'Multiply', 'Divide'].include?(self)
        true
      else
        print_string "Enter a valid operator. Please try again"
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
  puts "*** #{text} ***"
end

def chomp_it
  gets.chomp
end

def calculator
  begin
    print_string "Please enter your first number"
    num1 = chomp_it
  end while !num1.numeric?
  
  begin
  print_string "Please enter your second number"
  num2 = chomp_it
  end while !num2.numeric?

  begin
  print_string "Select operator: 1.Add 2.Subtract 3.Multiply 4.Divide"
  operator = chomp_it
  end while !operator.valid_operator?

  case operator
  when '1', 'Add'
    result = num1.to_f + num2.to_f
  when '2', 'Subtract'
    result = num1.to_f - num2.to_f
  when '3', 'Multiply'
    result = num1.to_f * num2.to_f
  when '4', 'Divide'
    if num2 == '0'
      result = "You cannot divide by zero"
    else
      result = num1.to_f / num2.to_f
    end
  end

  print_string "The result is: #{result}"
end

begin
  calculator
  
  begin
    print_string "Would you like to perform another calculation: Y or N"
    decision = chomp_it
  end while !decision.valid_decision?
  
end while decision == 'Y'
  
  