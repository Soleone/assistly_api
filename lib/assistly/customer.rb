module Assistly
  module API
    
    class Customer < Base
      def self.all(options = {})
        get(options)
      end
      
      def self.update_attributes(options)
        put(options)
      end
      
      def self.create_phone(options)
        options[:nested_resource] = "/phones"
        post(options)
      end
      
    end
    
  end
end