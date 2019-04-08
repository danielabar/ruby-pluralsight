def greet(greeting)
  puts greeting + ", captain!"
end

result = class Spaceship
  answer = 7 * 6
  puts "Calculating in class context: " + answer.to_s
  greet("Good morning")
  answer
end

puts "The class calculated: " + result.to_s
puts Spaceship.superclass

# Calculating in class context: 42
# Good morning, captain!
# The class calculated: 42
# Object