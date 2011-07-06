require File.dirname(__FILE__) + '/test_helper'

class ArticleTest < Test::Unit::TestCase
  include Assistly::API
  
  def test_articles
    articles = Article.all
    puts articles
  end
  
end