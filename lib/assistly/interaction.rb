module Assistly
  module API
    
    class Interaction < Base
      def self.all
        get
      end
      
      def self.create(options)
        post(options)
      end
    end
    
  end
end