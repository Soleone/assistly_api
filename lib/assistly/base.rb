module Assistly
  module API
    
    class Base
      BASE_PATH = "/api/v1"
      DEFAULT_FORMAT = "json"
    
      def self.debug_mode=(debug)
        @@debug_mode = debug
      end
      
      def self.debug_mode
        @@debug_mode
      end
      
      def self.path
        "#{BASE_PATH}/#{resource_name}"
      end
    
      def self.full_path(additional_path = "")
        "#{path}#{additional_path}.#{DEFAULT_FORMAT}"  
      end
    
      def self.resource_name
        class_name = self.name.split('::').last.downcase
        "#{class_name}s"
      end
      
      def self.authentication=(authentication)
        @@authentication = authentication
      end
      
      def self.authentication
        @@authentication
      end
      
      def self.client
        @@client ||= @@authentication.access_token
      end
    
      def self.get(options = {})
        response = client.get(full_path(options[:nested_resource]), options)
        puts response.body if debug_mode
        response.body
      end
      
      def self.post(options = {})
        puts full_path(options[:nested_resource])
        response = client.post(full_path(options[:nested_resource]), options)
        puts response.body if debug_mode
        JSON.parse(response.body)
      end
      
      def self.put(options = {})
        response = client.put(full_path("/#{options[:id]}"), options)
        puts response.body if debug_mode
        JSON.parse(response.body)
      end      
    end

  end
end