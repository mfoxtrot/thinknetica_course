# Route class is used to move trains between stations
class Route
  attr_reader :first_station
  attr_reader :last_station
  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = [@first_station, @last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  private

  def validate!
    message = 'Stations should not be nil'
    raise message if @first_station.nil? || @last_station.nil?
    true
  end
end
