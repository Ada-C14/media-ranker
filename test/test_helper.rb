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

  # Add more helper methods to be used by all tests here...
  def perform_login(user = nil)

    unless user
      new_user = User.new(name: "second test user")
      login_data = {
        user: {
          name: new_user.name
        }
      }
    else
      login_data = {
        user: {
          name: user.name
        }
      }
    end

    post login_url, params: login_data

    unless user
      new_user = User.find_by(name: "second test user")
      expect(session[:user_id]).must_equal new_user.id
      return new_user
    else
      expect(session[:user_id]).must_equal user.id
      return user
    end

  end
  

end
