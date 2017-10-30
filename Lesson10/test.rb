require_relative 'accessors.rb'
require_relative 'validation.rb'
class Test
  extend Accessors
  extend Validation

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :s, String

  validate :a, :presence
  validate :a, :type, Integer
end


t = Test.new
puts "a_history = #{t.a_history}"
t.a = 10
t.a = 20
puts t.a
puts "a_history = #{t.a_history}"
puts "==================="
t.s = "123"
puts "s=#{t.s}"

t=Test.new
t.a="100"
puts t.a
puts t.valid?
