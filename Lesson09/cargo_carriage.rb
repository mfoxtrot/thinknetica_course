# This is a CargoCarriage class. It has specific methods to manage volume
class CargoCarriage < Carriage
  attr_reader :volume
  attr_reader :taken_volume

  def initialize(volume)
    @volume = volume
    @available_volume = volume
    @taken_volume = 0
    super(:cargo)
  end

  def take_volume(volume_to_take)
    return if volume_to_take > @available_volume
    @available_volume -= volume_to_take
    @taken_volume += volume_to_take
  end

  def available_volume
    @volume - @taken_volume
  end
end
