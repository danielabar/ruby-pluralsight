$debug = true

def debug_only
  yield if $debug && block_given?
end

class Spaceship
  def initialize
    @debug_attrs = {containment_status: :ok, core_temp: 350}
  end

  def launch
    # this block prints out debug_attrs instance variable, don't need to pass it in as block argument
    # since block is defined inside class, it can access instance variables
    debug_only { p @debug_attrs}
  end
end

Spaceship.new.launch # {:containment_status=>:ok, :core_temp=>350}