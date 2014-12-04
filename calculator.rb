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
end

def print_string(text)
  puts "*** #{text} ***"
end

def chomp_it
  gets.chomp
end

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
when '1' || 'Add'
  result = num1.to_f + num2.to_f
when '2' || 'Subtract'
  result = num1.to_f - num2.to_f
when '3' || 'Multiply'
  result = num1.to_f * num2.to_f
when '4' || 'Divide'
  result = num1.to_f / num2.to_f
end

print_string "The result is #{result}"
