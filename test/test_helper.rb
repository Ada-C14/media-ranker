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

  # method takes username as parameter & creates user hash and makes post request to login path
  def login(username = "Grace Hopper")
    # arrange
    # user_hash is form data that's submitted when logging in new user
    user_hash = {
        user: {   # key for user b/c it's form_with. parent key is model name.
                  username: username   # field: username
        }
    }

      # act
      post login_path, params: user_hash # send post request to path w/ params user_hash

    # user = User.find_by(username: username)
    user = User.find_by(username: user_hash[:user][:username])
    return user
  end
end
