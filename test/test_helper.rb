require File.dirname(__FILE__) + '/../lib/assistly'
require 'test/unit'
require 'yaml'
ASSISTLY_CONFIG = YAML::load(File.open('assistly.yml'))[:production]

class Test::Unit::TestCase
  
  # Enter credentials for testing below

  def subdomain
    ASSISTLY_CONFIG[:subdomain]
  end
  
  def consumer_key
    ASSISTLY_CONFIG[:consumer_key]
  end
  
  def consumer_secret
    ASSISTLY_CONFIG[:consumer_secret]
  end
  
  def access_token_key
    ASSISTLY_CONFIG[:oauth_token]
  end
  
  def access_token_secret
    ASSISTLY_CONFIG[:oauth_token_secret]
  end
end