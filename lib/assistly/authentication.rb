module Assistly
  module API
    
    class Authentication
      attr_reader :consumer_key, :consumer_secret, :site
      attr_reader :access_token_key, :access_token_secret
      attr_reader :request_token, :access_token


      def initialize(consumer_key, consumer_secret, subdomain, options = {})
        @consumer_key, @consumer_secret = consumer_key, consumer_secret
        @site = "https://#{subdomain}.assistly.com"
        @access_token_key, @access_token_secret = options[:access_token_key], options[:access_token_secret]
      end

      def valid?
        access_token.get('/api/v1/account/verify_credentials.json')
      end
    
      def authorize_url
        request_token.authorize_url
      end
    
      def consumer
        @consumer ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, :site => @site)
      end

      def request_token
        @request_token ||= consumer.get_request_token
      end
    
      def access_token(options = {})      
        @access_token ||= if @access_token_key && @access_token_secret
          OAuth::AccessToken.new(consumer, @access_token_key, @access_token_secret)
        else
          request_token.get_access_token(:oauth_verifier => options[:oauth_verifier])
        end
      end
    end
    
  end
end