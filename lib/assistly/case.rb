module Assistly
  module API
    
    class Case < Base
      # Work around the fact that Desk.com doesn't allow ordering the results
      # Does two (or three) API calls:
      # 1. get the total number of tickets
      # 2. fetch the last page of tickets
      # 3. fetch the previous page to get any missing tickets to ensure +count+ number of cases get returned
      def self.all_recent(options = {})
        count = options[:count] || 20
        old_cases = all(options.merge(:count => 1))

        total = old_cases.total
        latest_page = (total / count.to_f).ceil

        latest_cases = all(options.merge(:page => latest_page))
        
        if latest_cases.size < count
          previous_cases = all(options.merge(:page => latest_page - 1))
          latest_cases = previous_cases[latest_cases.size..count] + latest_cases
          latest_cases.sort!{|a, b| b.created_at <=> a.created_at}

          # TODO: UGLY HACK, PLEASE REFACTOR RESULT TO ACCEPT AN ARRAY OF OBJECTS 
          meta_class = (class << latest_cases; self; end)
          meta_class.send(:define_method, :total, lambda{total})
          meta_class.send(:define_method, :count, lambda{count})
          meta_class.send(:define_method, :page,  lambda{latest_page})
        end
        
        latest_cases
      end

      def agent_url
        "#{self.class.authentication.site}/agent/case/#{id}"
      end
    end
    
  end
end