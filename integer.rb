class Integer
  # Converts an integer into a 4-bit array, as used by the s-boxes
  def to_bits
       [(self>>2)&1, (self>>1)&1, self&1]
  end
end
