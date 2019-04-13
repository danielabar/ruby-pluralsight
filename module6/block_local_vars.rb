class Spaceship
  def initialize
    @debug = true
    @debug_attrs = {containment_status: :ok, core_temp: 350}
  end

  # method that executes a block via yield, passing in instance var debug_attrs
  def debug_only
    return nil unless @debug
    return nil unless block_given?
    puts "Running debug code..."
    yield @debug_attrs
  end

  def locate_cargo
    attrs = {weight: 10, destination: "Earth"}

    # BAD: shadowing
    # debug_only do |attrs|
    #   attrs[:cargo_accessed] = true
    # end

    # TRY
    # debug_only do |_d_attrs|
    #   attrs = {}
    #   attrs[:cargo_accessed] = true
    # end

    # FIX: block local
    debug_only do |_d_attrs; attrs|
      attrs = {}
      attrs[:cargo_accessed] = true
    end

    p attrs
    p @debug_attrs
  end
end

ship = Spaceship.new
ship.locate_cargo

# BAD: shadowing
# Running debug code...
# {:weight=>10, :destination=>"Earth"}
# {:containment_status=>:ok, :core_temp=>350, :cargo_accessed=>true}

# TRY
# Running debug code...
# {:cargo_accessed=>true}
# {:containment_status=>:ok, :core_temp=>350}

# FIX
# Running debug code...
# {:weight=>10, :destination=>"Earth"}
# {:containment_status=>:ok, :core_temp=>350}