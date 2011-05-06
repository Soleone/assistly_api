module Assistly
  module API
    
    class Result < DelegateClass(Enumerable)
      include Enumerable
      attr_reader :results, :total, :count, :page
      
      def initialize(hash, klass)
        @total = hash['total'].to_i
        @count = hash['count'].to_i
        @page  = hash['page'].to_i
        @results = hash['results'].collect do |resource|
          Resource.new(resource[klass])
        end
        super(@results)
      end
      
      def each(&blk)
        @results.each(&blk)
      end
    end
  end
end