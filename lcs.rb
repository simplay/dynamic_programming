require 'pry'
# least common subsequence (lcs)
# 
# given two strings X and Y, both having an arbitrary, not necessary equal length.
# Find the longest commong subsequence of the two strings.
# 

require_relative 'matrix'

x = ARGV[0] || "foobar"
y = ARGV[1] || "fancyride"

m = x.length + 1
n = y.length + 1
a = Matrix.new(m, n, 0) 

# solve
(1..m-1).each do |i|
  (1..n-1).each do |j|
    if x[i-1] == y[j-1]
      v = a.get(i-1, j-1) + 1
    else
      v = [
        a.get(i-1, j),
        a.get(i, j-1)
      ].max
    end
    a.set(i, j, v)
  end
end
l = a.get(m-1,n-1)

# backtrack
i = m-1
j = n-1
list = []
loop do
  break if l <= 0
  if x[i-1] == y[j-1]
    l = l - 1
    i = i - 1
    j = j - 1
    list << x[i]
  else
    v = a.get(i-1,j)
    w = a.get(i,j-1)
    if v > w
      i = i - 1
    else
      j = j - 1
    end
  end
end
subsequence = list.reverse
puts "lcm between"
puts "  x: #{x}"
puts "  y: #{y}"
puts "is: #{subsequence.join}"
