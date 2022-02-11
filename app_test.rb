# frozen_string_literal: true

require './app'
require 'minitest/autorun'
require 'rack/test'

class CorobotTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_response_with_correct_header
    ENV['X-COROBOT-TOKEN'] = 'correct'
    header 'X-COROBOT-TOKEN', 'correct'
    get '/roll'

    assert_equal 200, last_response.status
  end

  def test_response_with_wrong_header
    header 'X-COROBOT-TOKEN', 'wrong'
    get '/roll'

    assert_equal 403, last_response.status
  end

  def test_response_without_header
    get '/roll'

    assert_equal 403, last_response.status
  end
end
