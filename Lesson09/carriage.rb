# Example of using instance_counter module
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
# Carriage class
class Carriage
  include Manufacturer
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    message = 'Carriage type should only be :cargo or :passenger'
    raise message unless %i(cargo passenger).include? @type
    true
  end
end
