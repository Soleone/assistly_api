require File.dirname(__FILE__) + '/../lib/assistly'
require 'test/unit'
require 'yaml'

# Specify your credentials for the remote tests in test/credentials.yml
# subdomain:           'my_site'
# consumer_key:        'xxx'
# consumer_secret:     'yyy'
# access_token_key:    'zzz'
# access_token_secret: 'xyz'
  
filename = File.dirname(__FILE__) + '/credentials.yml'
CREDENTIALS = YAML.load(File.read(filename)) if File.exist?(filename)

class Test::Unit::TestCase
  def subdomain
    CREDENTIALS['subdomain']
  end
  
  def consumer_key
    CREDENTIALS['consumer_key']
  end
  
  def consumer_secret
    CREDENTIALS['consumer_secret']
  end
  
  def access_token_key
    CREDENTIALS['access_token_key']
  end
  
  def access_token_secret
    CREDENTIALS['access_token_secret']
  end
end