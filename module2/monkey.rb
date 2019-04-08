class Spaceship
  def batten_hatches
    puts "Batten the hatches!"
  end
end

ship = Spaceship.new

# re-open Spaceship class and override (aka replace) batten_hatches method
class Spaceship
  def batten_hatches
    puts "Avast"
  end
end

ship.batten_hatches # Avast