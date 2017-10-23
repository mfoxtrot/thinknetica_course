# Specific type of trains
class PassengerTrain < Train
  def type
    :passenger
  end

  def show_carriage_info
    each_carriage do |c, number|
      info = "Carriage #{number}. "
      info << "Total capacity: #{c.capacity}, "
      info << "available seats: #{c.available_seats}, "
      info << "taken: #{c.taken_seats}"
      puts info
    end
  end
end
