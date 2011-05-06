require File.dirname(__FILE__) + '/test_helper'

class CaseTest < Test::Unit::TestCase
  include Assistly::API
  
  def setup
    @authentication = Assistly::Authentication.new(consumer_key, consumer_secret, subdomain, :access_token_key => access_token_key, :access_token_secret => access_token_secret)
    Assistly::API::Base.authentication = @authentication
    # Assistly::API::Base.debug_mode = true
  end
  
  def test_case_agent_url
    interaction = Case.find(:id => 3463)
    assert_equal "https://#{subdomain}.assistly.com/agent/case/3463", interaction.agent_url
  end
  
  def test_get_cases
    puts Case.all.inspect
  end
  
  def test_get_cases_by_customer_email
    cases = Case.find(:email => 'dennistheisen@gmail.com', :count => 1)
    assert_equal 1, cases.count
    assert_equal 1, cases.size
    assert_equal 1, cases.page
    puts cases.first.inspect
  end
  
  def test_get_cases_by_customer_email_and_status
    cases = Case.find(:email => 'dennistheisen@gmail.com', :status => 'new,open,pending', :count => 50)
    puts cases.collect(&:preview).inspect
  end
end