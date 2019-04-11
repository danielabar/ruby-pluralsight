class Probe
  def self.next_probe_id
    @next_probe_id ||= 0
    @next_probe_id += 1
  end

  def initialize(size)
    @name = "Probe #{Probe.next_probe_id}"
    @type = :regular
    @size = size
  end

  # Return array of all of this classeses attribute values (name, type, size)
  def to_a
    instance_variables.map { |v| instance_variable_get(v) }
  end
end

# Use splat operator to convert instance of Probe class into array
p [*Probe.new(:large)] # ["Probe 1", :regular, :large]