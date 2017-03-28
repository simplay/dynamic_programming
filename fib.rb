require 'benchmark'

VALUES = [1, 1]

def fib(n)
  return 1 if (n == 0 || n == 1)
  return fib(n-1) + fib(n-2)
end

def fib_mem(n, values=VALUES)
  if values[n].nil?
    values << fib_mem(n-1) + fib_mem(n-2)
  end
  values[n]
end

n = 36
Benchmark.bm do |x|
  x.report("fib(#{n})") { fib(n) }
  x.report("fib_mem(#{n})") { fib_mem(n) }
end
