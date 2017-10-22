=begin
  Пример подклЮчения модуля InstanceCounter
=end
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

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
    raise "Carriage type should only be :cargo or :passenger" if not [:cargo, :passenger].include? @type
    true
  end
end
