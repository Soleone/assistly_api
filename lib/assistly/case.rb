module Assistly
  module API
    
    class Case < Base
      def self.all(options = {})
        get
      end
      
      def self.update(options)
        put(options)
      end
      
    end
    
  end
end