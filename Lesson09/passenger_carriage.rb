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
    if @available_seats > 0
      @available_seats -= 1
      @taken_seats += 1
    end
  end

  def available_seats
    @capacity - @taken_seats
  end
end
