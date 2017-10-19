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
    register_instance
  end
end
