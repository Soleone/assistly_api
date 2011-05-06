module Assistly
  module API
    module Client
      BASE_PATH = "/api/v1"
      DEFAULT_FORMAT = :json
      HTTP_VERBS = [:get, :post, :put, :delete, :head]

      @@debug_mode = false
  
      def debug_mode=(debug)
        @@debug_mode = debug
      end
  
      def debug_mode
        @@debug_mode
      end
  
      def authentication=(authentication)
        @@authentication = authentication
      end
  
      def authentication
        @@authentication
      end
  
      def client
        @@client ||= @@authentication.access_token
      end
  
      def find(options = {})
        get(options)
      end
      alias all find

      private

      def get(options = {})
        request(:get, options)
      end
  
      def post(options = {})
        request(:post, options)
      end
  
      def put(options = {})
        request(:put, options)
      end
  
      def resource_path
        "#{BASE_PATH}/#{resource_plural}"
      end
  
      def resource_singular
        self.name.split('::').last.downcase
      end
      
      def resource_plural
        "#{resource_singular}s"
      end
      
      def build_path(options, format_extension = true)
        options = options.dup
        path = resource_path
        path << "/#{options.delete(:id)}" if options[:id]
        path << options.delete(:nested_resource) if options[:nested_resource]
        path << ".#{DEFAULT_FORMAT}" if format_extension
        path << "?#{build_params(options)}" unless options.empty?
        path
      end
  
      def build_params(params)
        params.map{|key, value| "#{key}=#{value}"}.join('&')
      end
  
      def request(verb, options = {})
        raise ArgumentError, "must be one of #{HTTP_VERBS.join(',')}" unless HTTP_VERBS.include?(verb.to_sym)
        path = build_path(options)
        puts "Sending #{verb} request to #{path}..." if debug_mode
        response = client.send(verb, path)
        puts response.body.to_s if debug_mode
        hash = parse(response)
        if hash['results']
          Result.new(hash, self)
        else
          self.new(hash)
        end
      end
  
      def parse(response, format = DEFAULT_FORMAT)
        case format.to_sym
        when :json
          JSON.parse(response.body)
        else
          response.body
        end
      end
    end
  end
end