require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class CaseTest < Test::Unit::TestCase
  include Assistly::API
  
  def setup
    #Assistly::API::Base.debug_mode = true
    @site = Assistly::API::Base.authentication.site
  end
  
  def test_case_agent_url
    single_case = Case.find(:id => '27627')
    
    assert_equal "#{@site}/agent/case/27627", single_case.agent_url
  end
  
  def test_get_cases
    cases = Case.all(:count => 10)

    assert_equal 10, cases.size
  end
  
  def test_get_cases_by_customer_email
    cases = Case.find(:email => 'dennistheisen@gmail.com', :count => 10)
    
    assert_equal 10, cases.count
    assert_equal 10, cases.size
    assert_equal 1, cases.page

    first_case, second_case = cases[0], cases[1]
    assert first_case.created_at < second_case.created_at
  end
  
  def test_get_cases_by_customer_email_and_status
    cases = Case.find(:email => 'dennistheisen@gmail.com', :status => 'new,open,pending', :count => 50)
  end

  def test_all_recent
    cases = Case.all_recent(:email => 'dennistheisen@gmail.com', :count => 100)
    
    assert_equal 100, cases.size
    first_case, second_case = cases[0], cases[1]
    assert first_case.created_at > second_case.created_at

    assert_equal 'dennistheisen@gmail.com', first_case.email
  end
end