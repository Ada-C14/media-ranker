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

  # def login(username = "Username 1")
  #   @user_hash = {
  #       user: {
  #           username: username
  #       }
  #   }
  #
  #   post login_path, params: @user_hash
  #
  #   user = User.find_by(username: username)
  #   return user
  # end

  def perform_login(user = nil)
    user ||= User.first

    login_data = {
        user: {
            username: user.username,
        },
    }
    post login_path, params: login_data

    user = User.find_by(username: user.username)
    expect(user).wont_be_nil
    expect(session[:user_id]).must_equal user.id

    return user
  end

  def clear_database
    User.delete_all
    Work.delete_all
    Vote.delete_all
  end

end
