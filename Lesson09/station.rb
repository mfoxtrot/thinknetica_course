class Station
  attr_reader :trains
  attr_reader :name

  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
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
    @@all_stations
  end

  def valid?
    validate!
  rescue
    false
  end

  def each_train(&block)
    @trains.each { |t| block[t] }
  end

  private

  def validate!
    raise 'Name can not be nil' if @name.nil?
    raise 'Name should be at least 3 symbols' if @name.to_s.length < 3
    true
  end
end
