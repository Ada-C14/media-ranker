if ENV['RAILS_ENV'] ||= 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts "required simplecov"
  require_relative '../config/environment'
  require 'rails/test_help'
  require "minitest/rails"
  require "minitest/reporters" # for Colorized output
end
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
    user ||= User.first

    login_data = {
        user: {
            username: user.name,
        },
    }
    post login_path, params: login_data
    expect(session[:user_id]).must_equal user.id

    return user
  end
end

