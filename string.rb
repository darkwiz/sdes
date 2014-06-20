class String
  # Convert a "1010..." string into an array of bits and remove any other char
   def to_bits
    bitarr=[]
        self.each_char{|c| bitarr << c.to_i if c=='0' || c=='1'}
    bitarr
  end
end
