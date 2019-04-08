# frozen_string_literal: true

lander_count = 11

message = if lander_count > 10
  puts 'Launching probe'
else
  puts 'Waiting for test probes to return'
end

puts message