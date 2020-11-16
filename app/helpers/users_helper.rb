module UsersHelper

  def user_lookup(user_id)
    @users = User.all
    user = @users.find_by(id: user_id)
    return user.username
  end
end