class PassengerTrain < Train

  def type
    :passenger
  end

  def show_carriage_info
    self.each_carriage { |c, number| puts "Carriage #{number}. Total capacity: #{c.capacity}, available seats: #{c.available_seats}, taken: #{c.taken_seats}"}
  end
end
