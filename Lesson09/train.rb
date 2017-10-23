require_relative 'manufacturer.rb'
# Main train class
class Train
  include Manufacturer
  attr_reader :speed
  attr_reader :route
  attr_reader :carriages_number
  attr_reader :carriages
  attr_reader :number

  @@all_trains = {}
  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i

  def initialize(number)
    @number = number
    validate!
    @carriages_number = 0
    @speed = 0
    @carriages = []
    @@all_trains[number] = self
  end

  def brake
    @speed = 0
  end

  def add_carriage(carriage)
    return unless carriage.type == type
    brake
    add_carriage!(carriage)
  end

  def remove_carriage(carriage)
    return unless carriage.type == type
    brake
    remove_carriage!(carriage) if carriages.include? carriage
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    @route.first_station.operate_train self
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def move_forward
    move_forward! unless last_station?
  end

  def move_backward
    move_backward! unless first_station?
  end

  def next_station
    return unless @current_station_index < @route.stations.count - 1
    @current_station_index + 1
  end

  def previous_station
    @current_station_index - 1 if @current_station_index > 0
  end

  def self.find(number)
    @@all_trains[number]
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  # Each method expecting a block
  def each_carriage(&block)
    @carriages.each_with_index { |c, i| block[c, i] }
  end

  protected

  attr_writer :speed

  # This method will be overriden in subclasses
  def type; end

  def show_carriage_info; end

  private

  # Dangerous methods
  attr_reader :current_station_index
  def remove_carriage!(carriage)
    @carriages.delete(carriage)
    @carriages_number -= 1
  end

  def add_carriage!(carriage)
    @carriages << carriage
    @carriages_number += 1
  end

  # Methods to check routes
  def last_station?
    @current_station_index == @route.stations.count - 1
  end

  def first_station?
    @current_station_index.zero?
  end

  def move_forward!
    current_station.dispatch_train self
    @current_station_index += 1
    current_station.operate_train self
  end

  def move_backward!
    current_station.dispatch_train self
    @current_station_index -= 1
    current_station.operate_train self
  end

  def validate!
    raise 'Wrong train number format' if NUMBER_FORMAT !~ @number
    true
  end
end
