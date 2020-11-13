ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
require 'date'
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processor) # causes out of order output.

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def perform_login(username = nil)
    user = User.find_by(name: username)

    user ||= User.first

    login_data = {
      user: {
        name: user.name,
      },
    }

    post login_path, params: login_data

    # Verify the user ID was saved
    expect(session[:user_id]).must_equal user.id

    return user
  end
end
