module Assistly
  module API
    
    class Base < OpenStruct
      extend Client
      
      def initialize(hash)
        class_name = self.class.name.split('::').last.downcase
        
        hash = hash['results'] if hash.key?('results')

        @properties = hash[class_name]
        super(hash[class_name])
      end
      
      def id
        @properties['id']
      end

      def self.update_attributes(hash)
        put(hash)
      end
    end
  end
end