module Assistly
  module API
    
    class Resource < OpenStruct
      def initialize(hash)
        @properties = hash
        super
      end
      
      def id
        @properties['id']
      end
    end
  end
end