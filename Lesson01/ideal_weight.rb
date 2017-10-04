print "Как вас зовут? "
user_name = gets.chomp.downcase.capitalize

print "Ваш рост в см? "
user_height = Integer(gets.chomp)

ideal_weight = user_height - 110

if ideal_weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{user_name}, ваш идеальный весь равен #{ideal_weight} кг"
end
