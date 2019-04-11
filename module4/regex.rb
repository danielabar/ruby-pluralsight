p "Time is 12:13am".scan(/\d+/)
# ["12", "13"]

puts "Alex Korban".gsub(/([a-zA-Z]+) ([a-zA-Z]+)/, "\\2, \\1")
# Korban, Alex

puts "Alex Korban".gsub(/([a-zA-Z]+) ([a-zA-Z]+)/, '\2, \1')
# Korban, Alex

s = "Password: b1a12"
puts s.gsub(/(Password:)\s+(\w+)/) { |_match| "#{$1} " + "*" * $2.length }
# Password: *****