require 'uri'

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
      
      def all(options = {})
        get(options)
      end
      
      def create(options = {})
        post(options)
      end
      
      def update(options = {})
        put(options)
      end
      
      
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
      
      def build_path(options, verb)
        path = resource_path
        path << "/#{options.delete(:id)}" if options[:id]
        path << options.delete(:nested_resource) if options[:nested_resource]
        path << ".#{DEFAULT_FORMAT}"
        path << "?#{build_params(options)}" if options.any? && !require_body?(verb)
        path
      end
  
      def build_params(params)
        params.map{|key, value| "#{URI.escape(key.to_s)}=#{URI.escape(value.to_s)}"}.join('&')
      end
  
      def request(verb, options = {})
        options = options.dup
        raise ArgumentError, "must be one of #{HTTP_VERBS.join(',')}" unless HTTP_VERBS.include?(verb.to_sym)

        path = build_path(options, verb)
        body = options.any? ? options : nil if require_body?(verb)

        method_params = [verb, path, body]
        response = client.send(*method_params.compact)
        
        debug_request(verb, path, body, response)
        
        hash = parse(response)
        if !hash['results'] || (hash['success'] && hash['total'].nil?)
          self.new(hash)
        else
          Result.new(hash, self)
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
      
      def debug_request(verb, path, body, response)
        return unless debug_mode
        puts "Sent #{verb.to_s.upcase} request to #{path}"
        puts "Body:\n#{body}" if body
        puts "\nResponse:\n#{response.body}"
      end
      
      def require_body?(verb)
        [:post, :put].include?(verb.to_sym)
      end
    end
  end
end