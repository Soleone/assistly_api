module Assistly
  module API
    
    class Customer < Base
      def self.all(options = {})
        get
      end
      
      def self.update(options)
        put(options)
      end
      
      def self.create_phone(options)
        options[:nested_resource] = "/#{options[:id]}/phones"
        post(options)
      end
      
    end
    
  end
end