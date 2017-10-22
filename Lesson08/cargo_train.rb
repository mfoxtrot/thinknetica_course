class CargoTrain < Train

  def type
    :cargo
  end

  def show_carriage_info
    self.each_carriage {|c, number| puts "Carriage: #{number}. Total volume: #{c.volume}, available volume: #{c.available_volume}, taken volume: #{c.taken_volume}"}
  end
end
