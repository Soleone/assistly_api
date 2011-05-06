module Assistly
  module API
    
    class Case < Base
      def agent_url
        "#{self.class.authentication.site}/agent/case/#{id}"
      end
    end
    
  end
end