def leap_year?(year)
  if year % 4 == 0
    if year % 100 == 0
      if year % 400 == 0
        1
      else
        0
      end
    else
      1
    end
  else
    0
  end
end

print "Введите день: "
day = gets.chomp.to_i

print "Введите месяц: "
mon = gets.chomp.to_i

print "Введите год: "
year = gets.chomp.to_i

months = [31,28,31,30,31,30,31,31,30,31,30,31]#Количество дней по месяцам
months[1] += leap_year?(year)#Коррекция февраля на високосный год

day_of_year = day
i = 1
while i<mon
  day_of_year += months[i-1]
  i += 1
end

puts "Порядковый номер дня: #{day_of_year}"
