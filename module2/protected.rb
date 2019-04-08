class Spaceship
  def launch
    batten_hatches
  end

  attr_reader :call_sign
  protected :call_sign

  def initialize
    @call_sign = "Dreadnought"
  end

  def call_sign_matches?(other)
    call_sign == other.call_sign
  end
end

class SpritelySpaceship < Spaceship
  def initialize
    @call_sign = "Fast cruiser "
  end
end

ship = Spaceship.new
fast_ship = SpritelySpaceship.new

puts fast_ship.call_sign_matches?(ship) # false
puts ship.call_sign # trying to invoke protected method directly results in error
# protected method `call_sign' called for #<Spaceship:0x00007fac318d8f08 @call_sign="Dreadnought"
# > (NoMethodError)