require File.dirname(__FILE__) + '/test_helper'

class CaseTest < Test::Unit::TestCase
  def setup
    @authentication = Assistly::Authentication.new(consumer_key, consumer_secret, subdomain, :access_token_key => access_token_key, :access_token_secret => access_token_secret)
    Assistly::API::Base.authentication = @authentication
  end
  
  def test_get_cases
    puts Assistly::API::Case.all
  end
end