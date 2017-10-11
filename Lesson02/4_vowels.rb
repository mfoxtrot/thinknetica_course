alphabet = []
result = {}

for s in 'а'..'я'
  alphabet << s
end
alphabet.insert(6,'ё')

alphabet.each_with_index do |s,index|
  result[s.to_sym] = index + 1 if 'аеёиоуыэюя'.include? s
end

puts result
