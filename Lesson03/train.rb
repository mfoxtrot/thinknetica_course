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
    @carriages_number = @carriages_number - 1 if @carriages_number > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
  end

  def move_forward
    if @current_station < @route.stations.count - 1
      @route.stations[current_station].dispatch_train self
      @current_station += 1
      @route.stations[current_station].operate_train self
    end
  end

  def move_backward
    if @current_station > 0
      @route.stations[current_station].dispatch_train self
      @current_station -= 1
      @route.stations[current_station].operate_train self
    end
  end

  def next_station
    @current_station + 1 if @current_station < @route.stations.count - 1
  end

  def previous_station
    @current_station -1 if @current_station > 0
  end
end
