module Validation
  module ClassMethods
    attr_accessor :to_validate

    def validate(var_name, validation_type, *args)
      @to_validate ||= {}
      @to_validate[var_name] ||= []
      @to_validate[var_name] << {
        method: "validate_#{validation_type}!",
        args: args
      }
      puts "to_validate: #{to_validate}"
    end
  end

  module InstanceMethods
    define_method('validate!') do
      self.class.to_validate.each do |key, value|
        value.each do |validation_params|
          method_name = validation_params[:method]
          args = validation_params[:args]
          send(method_name, instance_variable_get("@#{key}"), *args)
        end
      end
      true
    end

    def validate_presence!(var)
      raise "Variable #{var} is nil" if var.nil?
    end

    def validate_format!(var, format_string)
      message = "Variable #{var} hasn't exceptable format #{format_string}"
      raise message unless var =~ format_string
    end

    def validate_type!(var, checking_class)
      message = "Var #{var} has wrond class. Right is #{checking_class}"
      raise message unless var.class == checking_class
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
