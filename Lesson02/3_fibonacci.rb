a  = Array.new

a[0] = 1
a[1] = 1
i = 2

loop do
  s = a[i-1] + a[i-2]
  break if s > 100
  a << s
  i += 1
end

puts a
