a  = [1,1]

loop do
  s = a[-1] + a[-2]
  break if s > 100
  a << s
end

puts a
