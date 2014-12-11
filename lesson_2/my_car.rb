module SportMode
  def sport_feature(type)
    puts "You have the #{type} available."
  end
end

class Vehicle
  
  @@number_of_objects = 0
  
  attr_reader :year, :model
  attr_accessor :color, :speed
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_objects += 1
  end
  
  def self.petrol_mileage(miles, litres)
    puts "#{miles/litres} miles per litre of petrol"
  end
  
  def self.how_many_objects
    puts "There has been #{@@number_of_objects} created."
  end
  
  def speed_up(how_much)
    self.speed += how_much
    puts "You have accelerated and your speed is #{speed}"
  end
  
  def brake(how_much)
    self.speed -= how_much
    puts "You have braked and your speed is #{speed}"
  end
  
  def shut_off
    self.speed = 0
    puts "Current speed is #{speed}.  we have shut the engine off"
  end
  
  def spray_paint(new_color)
    current_color = color
    self.color = new_color
    puts "The color was initially #{current_color} but you have spray painted it #{color}"
  end
  
  def age
    puts "The vehicle is #{years_old} years old"
  end
  
  private
  
  def years_old
    year_now = Time.now.year
    year_now - year
  end
  
end

class MyCar < Vehicle
  
  include SportMode
  
  NUMBER_OF_DOORs = 4

  def to_s
    "My car is a #{model}, is #{color} and manufactured in #{year}"
  end
  
end

class MyTruck < Vehicle
  
  NUMBER_OF_DOORS = 2
  
end


skoda = MyCar.new(2010, 'Red', 'Octavia')
puts skoda.year
puts skoda.color
skoda.color = 'Blue'
puts skoda.color
puts skoda.model

skoda.speed_up(20)
skoda.speed_up(5)
skoda.brake(10)
skoda.shut_off

skoda.spray_paint('Black')

MyCar.petrol_mileage(200, 40)

puts skoda

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

skoda.age

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)



class Animal
  def a_public_method
    "Will this work? " + a_protected_method
  end

  private

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
puts fido.a_public_method 
