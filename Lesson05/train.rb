require_relative 'manufacturer.rb'

class Train
  include Manufacturer
  attr_reader :speed
  attr_reader :route
  attr_reader :carriages_number
  attr_reader :carriages
  attr_reader :number


  def initialize(number)
    @number = number
    @carriages_number = 0
    @speed = 0
    @carriages = []
  end

  def set_speed(speed)
    @speed = speed
  end

  def brake
    self.set_speed 0
  end

  def add_carriage(carriage)
    if carriage.type == self.type
      brake
      add_carriage!(carriage)
    end
  end

  def remove_carriage(carriage)
    if carriage.type == self.type
      brake
      remove_carriage!(carriage) if self.carriages.include? carriage
    end
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    @route.first_station.operate_train self
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def move_forward
    move_forward! if not last_station?
  end

  def move_backward
    move_backward! if not first_station?
  end

  def next_station
    @current_station_index + 1 if @current_station_index < @route.stations.count - 1
  end

  def previous_station
    @current_station_index -1 if @current_station_index > 0
  end

  protected
  #Этот метод будет перекрываться в наследниках и возвращать тип поезда
  def type
  end

  private
=begin
  Следующие методы вынесены в приватную секцию, т.к. они не должны  быть видны
  извне. Их можно вызывать только в методах класса, после соответствующих
  проверок. В данном случае должна быть проверка на соответствие типа вагона
  типу поезда, а в случае отцепки вагона еще и на существование этого вагона
  в составе поезда. Кроме того, в публичных методах класса из которых будут
  вызываться эти методы должен быть вызов метода торможения поезда.
=end
  attr_reader :current_station_index
  def remove_carriage!(carriage)
    self.carriages.delete(carriage)
    @carriages_number -= 1
  end

  def add_carriage!(carriage)
    self.carriages << carriage
    @carriages_number += 1
  end

  #Служебные методы класса, должны использоваться для проверки маршрутов
  def last_station?
    @current_station_index == @route.stations.count - 1
  end

  def first_station?
    @current_station_index == 0
  end

=begin
  "Опасные" методы непосредственного перемещения поезда
  Должны вызываться только из методов класса после проверок на их безопасность
=end
  def move_forward!
    self.current_station.dispatch_train self
    @current_station_index += 1
    self.current_station.operate_train self
  end

  def move_backward!
    self.current_station.dispatch_train self
    @current_station_index -= 1
    self.current_station.operate_train self
  end
end
