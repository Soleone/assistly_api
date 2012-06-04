module Assistly
  module API
    
    class Case < Base
      # Work around the fact that Desk.com doesn't allow ordering the results
      # Does two (or three) API calls:
      # 1. get the last 100 tickets. If there are more than 100 in total:
      # 2. fetch the last page of tickets
      # 3. fetch the previous page to get any missing tickets to ensure +count+ number of cases get returned
      #
      # Also work around the fact that no case.email gets returned by setting it here if it was passed in
      def self.all_recent(options = {})
        count = options[:count] || 100
        email = options[:email]

        old_cases = all(options.merge(:count => count))

        total = old_cases.total
        latest_page = (total / count.to_f).ceil

        if total <= count
          return sorted_case_results(old_cases, total, count, latest_page, email)
        end

        latest_cases = all(options.merge(:page => latest_page))
        
        if latest_cases.size < count
          previous_cases = all(options.merge(:page => latest_page - 1))
          latest_cases = previous_cases[latest_cases.size..count] + latest_cases
        end
        
        sorted_case_results(latest_cases, total, count, latest_page, email)
      end

      # TODO: UGLY HACK, PLEASE REFACTOR RESULT TO ACCEPT AN ARRAY OF OBJECTS 
      def self.sorted_case_results(cases, total, count, latest_page, email = nil)
        if email
          cases.each{ |ticket| ticket.email = email }
        end

        cases.sort!{|a, b| b.created_at <=> a.created_at}

        meta_class = (class << cases; self; end)
        meta_class.send(:define_method, :total, lambda{total})
        meta_class.send(:define_method, :count, lambda{count})
        meta_class.send(:define_method, :page,  lambda{latest_page})

        cases
      end

      def agent_url
        "#{self.class.authentication.site}/agent/case/#{id}"
      end
    end
    
  end
end