module Assistly
  module API
    
    class Base < OpenStruct
      extend Client
      
      def initialize(hash)
        class_name = self.class.name.split('::').last.downcase
        @properties = hash[class_name]
        super(hash[class_name])
      end
      
      def id
        @properties['id']
      end
    end
  end
end