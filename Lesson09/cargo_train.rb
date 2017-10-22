# CargoTrain class having specific show_carriage_info method
class CargoTrain < Train
  def type
    :cargo
  end

  def show_carriage_info
    each_carriage do |c, number|
      info ||= "Carriage: #{number}. "
      info << "Total volume: #{c.volume}, "
      info << "available volume: #{c.available_volume}, "
      info << "taken volume: #{c.taken_volume}"
      puts info
    end
  end
end
