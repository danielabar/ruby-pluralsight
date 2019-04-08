# Outer scope
# This is a local variable - visibility limited to scope in which its created.
# Since it's defined at start of file, will be visible throughout this program.
lander_count = 10

def report
  # Inner scope shadows variable in outer scope
  # If variable defined within a method, then it's only visible within this method
  # This lander_count is a new variable that only exists within scope of method
  # Has no effect on lander_count variable in outer scope
  lander_count = 5
  puts lander_count
end

# Note no brackets to invoke report function because it doesn't take any arguments
report

puts lander_count
# Outputs:
# 5
# 10