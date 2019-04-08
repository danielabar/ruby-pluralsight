class Spaceship
  def launch
    batten_hatches
  end

  def batten_hatches
    puts "Batten the hatches!"
  end
  private :batten_hatches
end

class SpritelySpaceship < Spaceship
  def initialize
    batten_hatches # can access private method from subclass
  end
end

child = SpritelySpaceship.new

ship = Spaceship.new
ship.send :batten_hatches # Batten the hatches!
ship.batten_hatches # module2/visibility.rb:13:in `<main>': private method `batten_hatches' called for #<Spaceship:0x00007fe2f9a216b8> (NoMethodError)
