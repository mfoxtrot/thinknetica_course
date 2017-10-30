module Validation
  @@validation_types = { presence: 'validate_presence!', format: 'validate_format!',type: 'validate_type!' }

  @@to_validate = {}

  def validate(var_name, validation_type, *args)
    @@to_validate[var_name] ||= []
    @@to_validate[var_name] << { method: @@validation_types[validation_type], args: args }

    define_method("validate!") do
      @@to_validate.each do |key, value|
        value.each do |validation_params|
          method_name = validation_params[:method]
          args = validation_params[:args]
          send(method_name, instance_variable_get("@#{key}"), *args)
        end
      end
      true
    end

    define_method("validate_presence!") do |var|
      raise "Variable #{var_name} is nil" if var.nil?
    end

    define_method("validate_format!") do |var, format_string|
      message = "Variable #{var_name} hasn't exceptable format #{format_string}"
      raise message unless var =~ format_string
    end

    define_method("validate_type!") do |var, checking_class|
      message = "Variable #{var_name} has type that doesn't matter #{checking_class}"
      raise message unless var.class == checking_class
    end

    define_method("valid?") do
      begin
        send("validate!")
      rescue
        false
      end
    end
  end
end
