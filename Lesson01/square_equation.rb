puts "Введите коэффициенты квадратного уравнения:"
print "a="
a = gets.chomp.to_f

print "b="
b = gets.chomp.to_f

print "c="
c = gets.chomp.to_f

d = b**2 - 4*a*c

puts "D=#{d}"

if (d>0)
  s = Math.sqrt(d)
  x1 = (-b + s) / (2*a)
  x2 = (-b - s) / (2*a)
  puts "x1=#{x1}"
  puts "x2=#{x2}"
elsif (d==0)
  x = (-b) / (2*a)
  puts "x=#{x}"
elsif (d<0)
  puts "Корней нет"
end
