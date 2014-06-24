require "./array.rb"
require "./string.rb"
require "./integer.rb"

class Des
  def initialize
  end

# Take a 9 bits key and return an array with all the 8 bits subkeys K1..K3
def the_keys(k)
  arr = []
  for i in 0..3
      arr << k.left(i).first(8)
  end
  arr
end


def f(r,k)
 e = r.p1   # Obtain E(Ri-1)
 x = e.xor(k)
 bs = x.split4 # Split into B1..B8
 s = [] # Concatenate S1(B1)..S8(B8)
 bs.each_with_index{|b,i| s += b.s_box(i+1)}
 s
end

def encrypt(m,keys)
  l, r = m.split # Split it to give us Li Ri

  (0..2).each { |i| # Run the encryption rounds
    l, r = r, l.xor(f(r,keys[i])) # L => R, R => L + f(Ri-1,Ki)
    #puts l.to_s + ":L %s" % i
    #puts r.to_s + ":R %s" % i
  }
  rl = r + l # Swap and concatenate the two sides into RiLi
end

def decrypt(m,keys)
    l, r = m.split # Split it to give us Li Ri
  (0..2).to_a.reverse.each { |i| # Run the encryption rounds
    l, r = r, l.xor(f(r,keys[i])) # L => R, R => L + f(Ri-1,Ki)
    #puts l.to_s + ":L %s" % i
    #puts r.to_s + ":R %s" % i
  }
  rl = r + l # Swap and concatenate the two sides into RiLi
end



#############
#   Cryptanalysis   #
#############

def gen_mess(firstdiff, lastdiff)

 # puts "R0 first: %s" % firstdiff.to_s

 puts "Generazione di tutte le possibili combinazioni che danno provengono dai differenziali (%s ,%s)" % [ firstdiff.to_s,  lastdiff.to_s ]

end



end

# 12 bits message
m = '100010110101'.to_bits
# This is the 9 bits key
k = '111000111'.to_bits


d1=Des.new


keys = d1.the_keys(k)
puts "Original message : "+m.pretty(12)
#keys.each_with_index { |sk,i| puts "Key %d: %s" % [i,sk.pretty] }
enc = d1.encrypt(m,keys)
puts "Encrypted message:"+ enc.pretty(12)
dec= d1.decrypt(enc,keys)
puts "Decrypted message:"+ dec.pretty(12)

r_0_first = '001100'.to_bits.p1

d1.gen_mess(r_0_first.split4[0],'011') # for S1
d1.gen_mess(r_0_first.split4[1],'010') # for S1





