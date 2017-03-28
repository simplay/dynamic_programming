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
