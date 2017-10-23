require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
# Main program class to manipulate trains, stations, routes, carriages
class Main
  class << self
    attr_accessor :menu
    attr_accessor :trains_types_list
  end

  @menu = {
    main: [
      'MAIN MENU. You can:',
      "1. Manage stations ('stations' or '1')",
      "2. Manage routes ('routes' or '2')",
      "3. Manage trains ('trains' or '3')",
      "4. Exit ('exit' or '4')"
    ],
    routes: [
      'ROUTES MENU. You can:',
      "1. Create a route ('add' or '1')",
      "2. Add a station ('add_station' or '2')",
      "3. Remove a station ('remove_station' or '3')",
      "4. List routes ('list_routes' or '4')",
      "5. Exit ('exit' or '5')"
    ],
    stations: [
      'STATIONS MENU. You can:',
      "1. Create a station ('add' or '1')",
      "2. List stations ('list' or '2')",
      "3. List trains ('trains' or '3')",
      "4. Exit ('exit' or '4')"
    ],
    trains: [
      'TRAINS MENU. You can:',
      "1. Create a train ('add' or '1')",
      "2. Set a route to a train ('set_route' or '2')",
      "3. Add a carriage ('add_carriage' or '3')",
      "4. Remove a carriage ('remove_carriage' or '4')",
      "5. Move forward ('move_forward' or '5')",
      "6. Move backward ('move_backward' or '6')",
      "7. Show carriages info ('carriage_info' or '7')",
      "8. Take a seat or volume '8'",
      "9. Exit ('exit' or '9')"
    ]
  }
  @trains_types_list = %i[cargo passenger]

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      command = select_menu(:main)
      puts command
      case command
      when 'stations', '1' then stations
      when 'routes', '2' then routes
      when 'trains', '3' then trains
      when 'exit', '4' then break
      end
    end
  end

  private

  def select_menu(type)
    self.class.menu[type].each { |m| puts m }
    print 'Your choice: '
    command = gets.chomp
    command
  end

  def list_routes
    @routes.each_with_index do |r, i|
      puts "#{i}: #{r.first_station.name}..#{r.last_station.name}"
    end
  end

  def list_stations
    puts 'List stations: '
    @stations.each_with_index { |s, i| puts "#{i}: #{s.name}" }
  end

  def list_route_stations(route)
    route.stations.each_with_index { |s, i| puts "#{i}: #{s.name}" }
  end

  def list_trains
    @trains.each_with_index { |t, i| puts "#{i}: #{t.number}" }
  end

  def list_carriages(train)
    train.show_carriage_info
  end

  def list_trains_types
    self.class.trains_types_list.each_with_index { |t, i| puts "#{i}: #{t}" }
  end

  def take_seat_or_volume
    train = select_train('Select the train: ')
    case train.type
    when :cargo then take_volume(train)
    when :passenger then take_a_seat(train)
    end
  end

  def take_volume(train)
    carriage = select_carriage(train, 'Select carriage to take volume: ')
    puts 'Enter volume to take: '
    volume = gets.chomp.to_i
    carriage.take_volume(volume)
  end

  def take_a_seat(train)
    carriage = select_carriage(train, 'Select carriage to take volume: ')
    carriage.take_a_seat
  end

  # Methods of base classes
  def create_station
    print 'Creating new station. Enter station nane: '
    name = gets.chomp
    @stations << Station.new(name)
  end

  def list_trains_by_station
    station = select_station('Select the station to list trains: ')
    station.each_train do |t|
      message = "Train: #{t.number}, "
      message << "type: #{t.type}, carriages: #{t.carriages.count}"
      puts message
    end
  end

  def create_route
    first_station = select_station('Select the first station: ')
    last_station = select_station('Select the last station: ')
    route = Route.new(first_station, last_station)
    @routes << route
  end

  def add_station
    route = select_route('Select the route to add a station: ')
    station = select_station('Selete the station to add: ')
    route.add_station(station)
  end

  def remove_station
    route = select_route('Select the route to remove a station: ')
    station = select_route_station(route, 'Enter the station to remove: ')
    route.remove_station(station)
  end

  def create_train
    begin
      print 'Enter the train number to create: '
      number = gets.chomp
      type = select_train_type('Select the train type to create: ')
      case type
      when :passenger then newtrain = PassengerTrain.new(number)
      when :cargo then newtrain = CargoTrain.new(number)
      end
    rescue StandardError => e
      puts e.message
      retry
    end
    @trains << newtrain
  end

  def setting_route
    train = select_train('Select the train to set the route: ')
    route = select_route('Select the route to set: ')
    train.route = route
  end

  def add_carriage
    train = select_train('Select the train to add a carriage: ')
    new_carriage = case train.type
                   when :cargo then create_cargo_carriage
                   when :passenger then create_passenger_carriage
                   end

    train.add_carriage(new_carriage)
  end

  def remove_carriage
    train = select_train('Select the train to remove carriage: ')
    carriage = select_carriage(train, 'Select the carriage to remove: ')
    train.remove_carriage(carriage)
  end

  def move_forward
    train = select_train('Select the train to move forward: ')
    train.move_forward
  end

  def move_backward
    train = select_train('Select the train to move backward: ')
    train.move_backward
  end

  def create_cargo_carriage
    puts 'Enter the carriage volume: '
    volume = gets.chomp.to_i
    CargoCarriage.new(volume)
  end

  def create_passenger_carriage
    puts 'Enter the carriage capacity: '
    capacity = gets.chomp.to_i
    PassengerCarriage.new(capacity)
  end

  def show_carriage_info
    train = select_train('Select the train to show carriage info: ')
    list_carriages(train)
  end

  # Choose values methods
  def select_train(label)
    list_trains
    print label
    train_index = gets.chomp.to_i
    @trains[train_index]
  end

  def select_route(label)
    list_routes
    print label
    route_index = gets.chomp.to_i
    @routes[route_index]
  end

  def select_carriage(train, label)
    list_carriages(train)
    print label
    carriage_index = gets.chomp.to_i
    train.carriages[carriage_index]
  end

  def select_station(label)
    list_stations
    print label
    station_index = gets.chomp.to_i
    @stations[station_index]
  end

  def select_route_station(route, label)
    list_route_stations(route)
    print label
    station_index = gets.chomp.to_i
    route.stations[station_index]
  end

  def select_train_type(label)
    list_trains_types
    print label
    type_index = gets.chomp.to_i
    self.class.trains_types_list[type_index]
  end

  # Methods menues
  def stations
    loop do
      command = select_menu(:stations)
      case command
      when 'add', '1' then create_station
      when 'list', '2' then list_stations
      when 'list_trains', '3' then list_trains_by_station
      when 'exit', '4' then break
      end
    end
  end

  def routes
    loop do
      command = select_menu(:routes)
      case command
      when 'add', '1' then create_route
      when 'add_station', '2' then add_station
      when 'remove_station', '3' then remove_station
      when 'list_routes', '4' then list_routes
      when 'exit', '5' then break
      end
    end
  end

  def trains
    loop do
      command = select_menu(:trains)
      case command
      when 'add', '1' then create_train
      when 'set_route', '2' then setting_route
      when 'add_carriage', '3' then add_carriage
      when 'remove_carriage', '4' then remove_carriage
      when 'move_forward', '5' then move_forward
      when 'move_backward', '6' then move_backward
      when 'carriage_info', '7' then show_carriage_info
      when '8' then take_seat_or_volume
      when 'exit', '9' then break
      end
    end
  end
end

program = Main.new
program.start
