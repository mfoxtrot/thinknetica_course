class Station

  attr_reader :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
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
end
