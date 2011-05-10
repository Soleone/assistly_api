require File.dirname(__FILE__) + '/test_helper'

class AuthenticationTest < Test::Unit::TestCase
  def setup    
    @authentication = Assistly::API::Authentication.new(consumer_key, consumer_secret, subdomain)
  end
  
  def test_initialize_sets_consumer_key_and_secret
    assert_equal consumer_key, @authentication.consumer_key
    assert_equal consumer_secret, @authentication.consumer_secret
  end
  
  def test_initialize_sets_consumer_key_and_secret
    assert_equal "https://#{subdomain}.assistly.com", @authentication.site
  end
  
  def test_consumer
    assert_instance_of OAuth::Consumer, @authentication.consumer
  end
  
  def test_authorize_url
    assert_match %r{https://#{subdomain}.assistly.com/oauth/authorize\?oauth_token=\w{16,}}, @authentication.authorize_url
  end
  
  def test_authenticate_from_access_token
    @authentication = Assistly::API::Authentication.new(consumer_key, consumer_secret, subdomain, :access_token_key => access_token_key, :access_token_secret => access_token_secret)
    assert @authentication.valid?
  end
end