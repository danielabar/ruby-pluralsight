class Cargo
  def method_missing(name, *args)
    case name
    when /^find_by_([a-z]+)_and_([a-z]+)$/
      # When passing hash to method as last argument, curly braces can be omitted
      find($1.to_sym => args[0], $2.to_sym => args[1])
    when /^find_by_([a-z]+)$/
      find($1.to_sym => args[0])
    else
      # IMPORTANT: Otherwise missing method error swallowed
      super
    end
  end

  def respond_to?(name, *args)
    return true if name =~ /^find_by_([a-z]+|[a-z]+_and_[a-z]+)$/
    super
  end

  private

  def find(attrs)
    puts "Finding cargo by #{attrs.inspect}"
  end
end

class Spaceship
  attr_reader :cargo

  def initialize
    @cargo = Cargo.new
  end
end

ship = Spaceship.new

ship.cargo.find_by_destination("Earth") # Finding cargo by {:destination=>"Earth"}
ship.cargo.find_by_weight_and_volume(100, 10) # Finding cargo by {:weight=>100, :volume=>10}
# ship.cargo.find_by_weight_or_volume(100, 10) # undefined method `find_by_weight_or_volume' for #<Cargo:0x00007f944d0f4c70> (NoMethodError)

# in order for this to return true, need to override `respond_to?` method
puts ship.cargo.respond_to? :find_by_destination # true
puts ship.cargo.respond_to? :find_by_destination_or_volume # false