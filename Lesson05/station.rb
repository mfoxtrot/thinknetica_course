class Station

  attr_reader :trains
  attr_reader :name

  @@ALL_STATIONS = []

  def initialize(name)
    @name = name
    @trains = []
    @@ALL_STATIONS << self
  end

  def operate_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select do |train|
      train if train.type == type
    end
  end

  def dispatch_train(train)
    @trains.delete(train)
  end

  def self.all
    @@ALL_STATIONS
  end
end
