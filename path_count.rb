require_relative 'matrix'

class Point
  attr_reader :x, :y

  def initialize(x,y)
    @x = x.to_i
    @y = y.to_i
  end

  def lx(other)
    @x - other.x + 1
  end

  def ly(other)
    @y - other.y + 1
  end

  def to_s
    "(#{x},#{y})"
  end
end

x0 = ARGV[0] || 1
y0 = ARGV[1] || 2
x1 = ARGV[2] || 7
y1 = ARGV[3] || 9

p0 = Point.new(x0,y0)
p1 = Point.new(x1,y1)

m = p1.lx(p0)
n = p1.ly(p0)
a = Matrix.new(m,n)

a.set(0,0,0)

(1..m-1).each do |k|
  a.set(k, 0, 1)
end

(1..n-1).each do |k|
  a.set(0, k, 1)
end

(1..m-1).each do |i|
  (1..n-1).each do |j|
    v = a.get(i-1, j) + a.get(i, j-1)
    a.set(i, j, v)
  end
end
puts "There are #{a.get(m-1, n-1)} paths from #{p0.to_s} to #{p1.to_s}"
