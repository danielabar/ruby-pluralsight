class Spaceship
  def launch(destination)
    @destination = destination
    # go towards destination
  end

  def destination
    @destination
  end
end

ship = Spaceship.new
ship.launch("Earth")

# 2 different ways to print out information about this ship object
puts ship.inspect  # #<Spaceship:0x00007ff7d51e9838 @destination="Earth">
p ship # #<Spaceship:0x00007fd4a58dd840 @destination="Earth">

puts ship.destination # Earth