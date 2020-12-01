ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login(username = 'grace hopper')
    user_hash = {
        user: {
            username: username
        }
    }

    post login_path, params: user_hash

    user = User.find_by(username: username)
    return user
  end
  # Add more helper methods to be used by all tests here...
end
