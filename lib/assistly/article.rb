module Assistly
  module API
    
    class Article < Base
      def self.all(options = {})
        get(options)
      end
    end
    
  end
end