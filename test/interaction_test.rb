require File.dirname(__FILE__) + '/test_helper'

class InteractionTest < Test::Unit::TestCase
  def setup
    @authentication = Assistly::API::Authentication.new(consumer_key, consumer_secret, subdomain, :access_token_key => access_token_key, :access_token_secret => access_token_secret)
    Assistly::API::Base.authentication = @authentication
    Assistly::API::Base.debug_mode = true
  end
  
  def test_get_cases
   # puts Assistly::API::Interaction.all
  end
  
  def test_post_case
    interaction = Assistly::API::Interaction.create(:interaction_subject => "Test interaction from API", :customer_email => 'dennis2@mymail.com', :interaction_channel => 'phone', :customer_phone => '654321')
    puts interaction.inspect
    # id = interaction['results']['case']['id']
    # assert Assistly::API::Case.update_attributes(:id => id, :user_id => 123456)
    #    
    # id = interaction['results']['customer']['id']
    # Assistly::API::Customer.create_phone(:id => id, :phone => '123456')
  end
end