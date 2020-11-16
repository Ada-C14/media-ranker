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
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login(name = "Grace Hopper")
    #arrange
    # this form is going to be submitted
    user_hash = {
        user: {
            name: name
        }
    }
    # sending post request with params(Grace) it'd increase the number of user by 1
    post login_path, params: user_hash

    user = User.find_by(name: name)
    return user
  end

  # Add more helper methods to be used by all tests here...
  # def perform_login(user = nil)
  #     user ||= User.first
  #
  #     login_data = {
  #       user: {
  #         name: user.name,
  #       },
  #     }
  #     post login_path, params: login_data
  #
  #     # Verify the user ID was saved - if that didn't work, this test is invalid
  #     expect(session[:user_id]).must_equal user.id
  #
  #     return user
  #   end
end
