module InstanceCounter

  module ClassMethods
    attr_accessor :instances
    def instances
      @instances ||= 0
    end

  end

  module InstanceMethods
    private
    def register_instance
      self.class.instances += 1
    end
  end
end
