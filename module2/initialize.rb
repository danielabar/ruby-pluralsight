class CargoHold
  def initialize(cargo_module_count)
    @cargo_module_count = cargo_module_count
  end
end

class Spaceship
  def initialize(name, cargo_module_count)
    @name = name
    @cargo_hold = CargoHold.new(cargo_module_count)
    @power_level = 100
  end
end

ship = Spaceship.new("Dreadnought", 4)
p ship # #<Spaceship:0x00007fc7d193d488 @name="Dreadnought", @cargo_hold=#<CargoHold:0x00007fc7d193d460 @cargo_module_count=4>, @power_level=100>