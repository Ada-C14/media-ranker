module UsersHelper
  def user_logged_in?(user)
    user? ? "login": "logout"
  end
end
