module Accessors
  def attr_accessor_with_history(*args)
    args.each do |arg|
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end

      define_method("#{arg}=") do |var|
        instance_variable_set("@#{arg}", var)
        instance_variable_set("@#{arg}_history", send("#{arg}_history") << var)
      end

      define_method("#{arg}_history") do
        if instance_variable_defined?("@#{arg}_history")
          instance_variable_get("@#{arg}_history")
        else
          instance_variable_set("@#{arg}_history", [])
        end
      end
    end
  end

  def strong_attr_accessor(arg, arg_class)
    define_method(arg) do
      instance_variable_get("@#{arg}")
    end

    define_method("#{arg}=") do |var|
      instance_variable_set("@#{arg}", var)
      send("#{arg}_validate_class!")
    end

    define_method("#{arg}_validate_class!") do
      var = instance_variable_get("@#{arg}")
      raise "Incorrect class of #{arg} value!" unless var.class == arg_class
    end
  end
end
