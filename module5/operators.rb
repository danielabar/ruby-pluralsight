class Spaceship
  attr_reader :name
  attr_reader :speed

  def initialize(name)
    @name = name
    @cargo = []
    @speed = 0
    @vessels = Hash.new { [] }
  end

  # override index operator - i.e. square brackets
  def [](type)
    @vessels[type]
  end

  # override index operator - i.e. square brackets equals
  # return value that can appear on left side of assig nment
  # takes index and value to set as arguments
  def []=(type, vehicles)
    @vessels[type] = vehicles
  end

  # override append operator
  # adds cargo object to cargo array instance variable
  def <<(cargo)
    @cargo << cargo
  end

  # override "spaceship" operator
  # used to make objects sortable
  # compares two objects, returns 0 if equal, -1 if first is less than second, 1 if first is greater than second
  def <=>(other)
    name <=> other.name
  end

  # override unary plus and minus operators
  def +@
    @speed += 10
  end

  def -@
    @speed -= 10
  end

  # Override not operator
  def !
    puts "Self destruct sequence initiated"
  end
end

class Lander; end

# use overridden [] operator
ship1 = Spaceship.new("Serentiy")
ship1[:landers] = [Lander.new, Lander.new]
puts "Landers: #{ship1[:landers].inspect}" # Landers: [#<Lander:0x00007fa4560408b0>, #<Lander:0x00007fa456040888>]

# use overridden << operator
class CargoPod; end
cargo_pod = CargoPod.new
ship1 << cargo_pod
p ship1
# #<Spaceship:0x00007fabc586c8d8 @name="Serentiy", @cargo=[#<CargoPod:0x00007fabc586c568>], @speed=0, @vessels={:landers=>[#<Lander:0x00007f abc586c810>, #<Lander:0x00007fabc586c7e8>]}>

# use overridden spaceship operator to sort an array of spaceships
ship2 = Spaceship.new("Dreadnought")
ship3 = Spaceship.new("Tranquillity")

p [ship1, ship2, ship3].sort.map {|s| s.name} # ["Dreadnought", "Serentiy", "Tranquillity"]

# use overridden unary +/- operators
+ship1
puts "Speed : #{ship1.speed}" # Speed : 10
-ship1
puts "Speed : #{ship1.speed}" # Speed : 0

# use overridden not operator - note it doesn't work as expected because override does something custom
if !ship1  # Self destruct sequence initiated
  puts "Ship isn't there"
end