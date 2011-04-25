module Assistly
  module API
    
    class Base
      BASE_PATH = "/api/v1"
    
      def self.debug_mode=(debug)
        @@debug_mode = debug
      end
      
      def self.debug_mode
        @@debug_mode
      end
      
      def self.path
        "#{BASE_PATH}/#{resource_name}"
      end
    
      def self.full_path
        "#{path}.json"  
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
        response = client.get(full_path, options)
        puts response.body if debug_mode
        response.body
      end
      
      def self.post(options = {})
        response = client.post(full_path, options)
        puts response.body if debug_mode
        JSON.parse(response.body)
      end
      
      def self.put(options = {})
        path = "#{self.path}/#{options[:id]}.json"
        puts "PATH: #{path}"
        response = client.put(path, options)
        puts response.body if debug_mode
        JSON.parse(response.body)
      end      
    end

  end
end