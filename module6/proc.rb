# `&` means this is a name for a block, not a regular parameter -> converts block to Proc
def debug_only(param = nil, &block)
  puts "Param class: #{param.class}"
  puts "Block class: #{block.class}" if block_given?  # block variable is instance of type Proc
end

# invoke debug_only method with empty hash as parameter
debug_only {}
puts "---"

# Create a Proc object by passing a block to Proc.new
# (could also use kernel method `proc` which is alias for Proc.new)
p = Proc.new {|_bla| puts "I'm a proc that says #{blah}!"}

debug_only(p)
puts "---"
debug_only(&p)

# Param class: NilClass
# Block class: Proc
# ---
# Param class: Proc
# ---
# Param class: NilClass
# Block class: Proc