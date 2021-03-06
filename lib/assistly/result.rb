module Assistly
  module API
    
    class Result < DelegateClass(Enumerable)
      include Enumerable
      attr_reader :results, :total, :count, :page
      
      def method_name
        
      end
      
      def initialize(hash, klass)
        @total = hash['total'].to_i
        @count = hash['count'].to_i
        @page  = hash['page'].to_i
        
        unless hash['results']
          @results = []
          return klass.new(hash)
        end

        @results = hash['results']
        @results = if @results.is_a?(Hash)
          [klass.new(@results[klass.to_s.downcase])]
        else
          @results.collect do |resource|
            klass.new(resource)
          end
        end
        super(@results)
      end
      
      def each(&blk)
        @results.each(&blk)
      end
    end
  end
end