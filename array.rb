class Array

# Splits an array into two parts

def split
    [self[0,self.length/2], self[self.length/2,self.length]]
end

# Per ogni elemento della stringa(table) passata effettua una
# permutazione/espansione sull'array di interesse (self)

def perm(table)
    table.split(' ').map{ |bit| self[bit.to_i-1] }
end


#Perform the Expansion/Permutation on Ri

def p1
    perm " 1   2    4   3    4    3    5    6 "
end

def s_box(b)
s_tables = "
                  S1

   5  2  1  6  3  4  7  0
   1  4  6  2  0  7  5  3

                  S2

   4  0  6  5  7  1  3  2
   5  3  0  7  6  2  1  4 "

# Find  the table we want
s_table = s_tables[s_tables.index('S%d'%b)+3,52]
s_table = s_table.split(' ')   # Convert from text to usable array
row = self.first # The row is found from the first bit
col = self[1]*4 + self[2]*2 + self[3] # The column is found from the last 3 bits
s_table[row*8+col].to_i.to_bits # The correct value is looked up, then converted to 3 bits output
end

  # splits into arrays of 4 bits
  def split4
    arr=[]
    subarr=[]
    self.each{|a|
      subarr<<a
      if subarr.length==4
        arr<<subarr
        subarr=[]
      end
    }
    arr
  end

# Performs a n-position array left shift

def left (n)
      self[n, self.length] + self[0, n]
end

 # xor's this and the other array
  def xor(b)
    i=0
    self.map{|a| i+=1; a^b[i-1]}
  end

  # join this array into a nicely grouped string
  def pretty(n=8)
    s=""
    self.each_with_index{|bit,i| s+=bit.to_s; s+=' ' if (i+1)%n==0}
    s
  end
end

