class String
  def space_out
    chars.join(" ")
  end

  # create copy of `size` method named `original_size`
  alias_method "original_size", "size"

  # override size, invoking original_size
  def size
    original_size * 2 - 1
  end
end

puts "abc".space_out # a b c
puts "abc".size # 5