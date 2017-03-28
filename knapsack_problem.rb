require 'pry'
# Given 
#   n items, each having a certain value and weight
#   a theft with a knapsack with a certain weight capacity m
#   
# which items should be taken s.t. the value is maximized but the capacity is not exceeded.

class Item
  attr_reader :weight, :value
  def initialize(weight, value)
    @weight = weight
    @value = value
  end
end

class Matrix

  # @param m [Integer] rows
  # @param n [Integer] columns
  def initialize(m, n, init_value=nil)
    @data = []
    m.times do
      items = []
      n.times do
        items << init_value 
      end
      @data << items
    end
  end

  def get(i,j)
    @data[i][j]
  end

  def set(i,j,v)
    @data[i][j] = v
  end
end


M = 20
items = [
  Item.new(10, 3),
  Item.new(2, 2),
  Item.new(8, 7),
  Item.new(5, 1),
  Item.new(1, 1),
  Item.new(2, 4),
  Item.new(3, 11),
]
N = items.count

# A(n,m) = max(
#   A(n-1,m), 
#   A(n-1, m-w_n) + v_n if m - g_n >= 0
# )

A = Matrix.new(N+1, M+1, 0)

(1..N).each do |i|
  (1..M).each do |j|
    if j - items[i-1].weight >= 0
      A.set(i,j, [
        A.get(i-1,j),
        A.get(i-1, j-items[i-1].weight) + items[i-1].value
      ].max)
    else
      A.set(i,j, A.get(i-1,j))
    end
  end
end


weight = M
list = []
(N-1).times do |i|
  idx = N-i-1
  item = items[idx]
  weight_idx = item.weight

  not_taken = A.get(idx, weight)
  taken = A.get(idx, weight-item.weight) + item.value

  if taken > not_taken
    list << idx
    weight = weight - item.weight
  end
end

puts "Optimal item indices: #{list}"
