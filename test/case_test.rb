require File.dirname(__FILE__) + '/test_helper'

class CaseTest < Test::Unit::TestCase
  include Assistly::API
  
  def setup
    # Assistly::API::Base.debug_mode = true
    @site = Assistly::API::Base.authentication.site
  end
  
  def test_case_agent_url
    interaction = Case.find(:id => '27627')
    assert_equal "#{@site}/agent/case/27627", interaction.agent_url
  end
  
  def test_get_cases
    puts Case.all.inspect
  end
  
  def test_get_cases_by_customer_email
    cases = Case.find(:email => 'dennistheisen@gmail.com', :count => 10)
    assert_equal 10, cases.count
    assert_equal 10, cases.size
    assert_equal 1, cases.page
    puts cases.last.inspect
  end
  
  def test_get_cases_by_customer_email_and_status
    cases = Case.find(:email => 'dennistheisen@gmail.com', :status => 'new,open,pending', :count => 50)
    puts cases.collect(&:preview).inspect
  end
end