def produce(_param = nil)
  # yield :a, :b1, :b2, :c
  yield :a, :c
end

my_proc = Proc.new {|a, *b, c| puts "I'm a proc that says #{a}, #{b}, #{c}"}

produce(&my_proc)
