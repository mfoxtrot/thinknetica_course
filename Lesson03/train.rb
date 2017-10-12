class Train
  attr_accessor :speed
  attr_accessor :route

  attr_reader :carriages_number
  attr_reader :current_station
  attr_reader :type

  def initialize(number, type, carriages_number)
    @number = number
    @type = type
    @carriages_number = carriages_number
  end

  def set_speed(speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def add_carriage
    brake
    @carriages_number += 1
  end

  def remove_carriage
    brake
    @carriages_number -= 1
  end

  def set_route(route)
    self.route = route
    @current_station = route.first_station
  end

  def move_forward
    @current_station.dispatch_train self
    @current_station = @route.list_stations[@route.list_stations.index(@current_station) + 1]
    @current_station.operate_train self
  end

  def move_backward
    @current_station.dispatch_train self
    @current_station = @route.list_stations[@route.list_stations.index(@current_station) - 1]
    @current_station.operate_train self
  end
end
