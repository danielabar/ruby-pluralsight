# Define a method that executes a block with arguments
def produce
  yield :spaceship, :freighter, :yacht, size: :s, seats: :leather
end

# Invoke method passing blcok args
produce do |what = :spaceship, *types, size: :m, engine_count: 2, **custom_components|
  puts "Producting #{what}"
  print "Types: "
  p types
  puts "Size: #{size}"
  puts "Engine count: #{engine_count}"
  print "Custom components: "
  p custom_components
end

# Producting spaceship
# Types: [:freighter, :yacht]
# Size: s
# Engine count: 2
# Custom components: {:seats=>:leather}