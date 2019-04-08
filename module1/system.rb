puts "Using backticks:"
res = `date`
# res = %x(date)
puts res

puts "Using system:"
res = system "date"
puts res