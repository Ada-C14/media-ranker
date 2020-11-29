require 'simplecov'
SimpleCov.start 'rails'do
add_filter '/bin/'
add_filter '/db/'
add_filter '/jobs/'
add_filter '/mailers/'
add_filter '/helpers/'
add_filter '/channels/'
add_filter '/controllers/application_controller.rb'
add_filter '/test/' # for minitest
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors) # causes out of order output.

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login(name = "Ada Cat")
   # Arrange, take the username to form a user_hash
   user_hash = {
     user: {
       name: name
      }
    }
    # Act, perform a post request using user_hash
    post login_path, params: user_hash
    # Find the user by the name
    user = User.find_by(name: name) 
    return user
 
  end

  # Add more helper methods to be used by all tests here...
end
