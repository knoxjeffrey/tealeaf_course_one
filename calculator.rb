def numeric?(number)
  true if Float(number) != nil rescue print_string "You must enter a number. Please try again" 
end

def valid_operator?(operator)
    if ['1', '2', '3', '4'].include?(operator)
      true
    else
      print_string "Enter a valid operator - choose numbers 1 to 4. Please try again"
    end
end

def valid_decision?(the_decision)
  if ['y', 'n'].include?(the_decision.downcase)
    return true
  else
    print_string "You must enter Y or N. Please try again"
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
  end while !numeric?(num1)
  
  begin
  print_string "Please enter your second number"
  num2 = chomp_it
  end while !numeric?(num2)

  begin
  print_string "Select operator: 1.Add 2.Subtract 3.Multiply 4.Divide"
  operator = chomp_it
  end while !valid_operator?(operator)

  case operator
  when '1'
    result = num1.to_f + num2.to_f
  when '2'
    result = num1.to_f - num2.to_f
  when '3'
    result = num1.to_f * num2.to_f
  when '4'
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
  end while !valid_decision?(decision)
  
end while decision == 'y'
  
  