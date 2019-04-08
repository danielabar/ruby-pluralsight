class Spaceship
  @thruster_count = 2
  def self.thruster_count
    @thruster_count
  end
end

class SpritelySpaceship < Spaceship
  @thruster_count = 4
end

class EconolineSpaceship < Spaceship
  @thruster_count = 1
end

puts SpritelySpaceship.thruster_count # outputs 4
puts EconolineSpaceship.thruster_count # outputs 1
puts Spaceship.thruster_count # outputs 2