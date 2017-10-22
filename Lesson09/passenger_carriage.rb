class PassengerCarriage < Carriage
  attr_reader :capacity
  attr_reader :taken_seats

  def initialize(capacity)
    @capacity = capacity
    @available_seats = capacity
    @taken_seats = 0
    super(:passenger)
  end

  def take_a_seat
    return if @available_seats.zero?
    @available_seats -= 1
    @taken_seats += 1
  end

  def available_seats
    @capacity - @taken_seats
  end
end
