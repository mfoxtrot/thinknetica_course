=begin
  Тестируем то, что получилось
=end

require_relative 'train'
require_relative 'station'
require_relative 'route'

s1 = Station.new('Moscow')
s2 = Station.new('Klin')
s3 = Station.new('Tver')
s4 = Station.new('Bologoe')
s5 = Station.new('Vishny Volochek')
s6 = Station.new('St Petersburg')

r = Route.new(s1, s6)
r.add_station s2
r.add_station s3
r.add_station s4
r.add_station s5

r.stations.each {|s| puts s.name}

t = Train.new('Krasnaya Strela', :passenger, 14)
t.speed = 40
puts t.speed

t.brake
puts t.speed

t.speed = 50
t.add_carriage
puts t.speed
puts t.carriages_number

t.speed = 60
t.remove_carriage
puts t.speed
puts t.carriages_number

t.set_route r
puts t.current_station.name

t.move_forward
puts t.current_station.name

t.move_backward
puts t.current_station.name

t.move_forward
t.move_forward
puts t.current_station.name
puts t.current_station.trains_by_type :passenger

puts s1.trains
