class Route

  attr_reader :first_station
  attr_reader :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
  end

  def add_station(station)
    @stations << station
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def list_stations
    [@first_station] + @stations + [@last_station]
  end
end
