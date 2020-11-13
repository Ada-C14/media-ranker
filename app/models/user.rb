class User < ApplicationRecord
  def login_form
    @user = User.new
  end
end
