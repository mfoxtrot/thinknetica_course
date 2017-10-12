class Station

  attr_reader :trains_list
  attr_reader :name

  def initialize(name)
    @name = name
    @trains_list = []
  end

  def operate_train(train)
    @trains_list << train
  end

  def trains_list_by_type(type)
    @trains_list.select do |train|
      train if train.type == type
    end
  end

  def dispatch_train(train)
    @trains_list.delete(train)
  end
end
