module Assistly
  module API
    
    class Base < OpenStruct
      extend Client
      
      def initialize(hash)
        class_name = self.class.name.split('::').last.downcase
        
        # requests to interaction endpoint will return case instances
        class_name = 'Case' if class_name == 'Interaction'
        
        @properties = hash[class_name]
        super(hash[class_name])
      end
      
      def id
        @properties['id']
      end
    end
  end
end