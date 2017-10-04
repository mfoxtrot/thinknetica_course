print "Сторона треугольника, a = "
a = gets.chomp.to_f

print "Сторона треугольника, b = "
b = gets.chomp.to_f

print "Сторона треугольника, c = "
c = gets.chomp.to_f

m = [a, b, c]
m.sort!

if m[2]**2 == (m[0]**2 + m[1]**2)
  if (m[0]==m[1])
    puts "Это прямоугольный и равнобедренный треугольник"
  else
    puts "Это прямоугольный треугольник"
  end
elsif (m[0]==m[1]) && (m[1]==m[2])
  puts "Это равносторонний треугольник"
end
