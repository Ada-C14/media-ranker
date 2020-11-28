class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)

    @works = Work.all
  end

  def create
    auth_hash = request.env["omniauth.auth"]

    # user = User.find_by(uid: auth_hash[:uid], provider: "github")
    user = User.find_by(uid: auth_hash[:uid], provider: params[:provider])

    if user
      # User was found in the database
      flash[:success] = "Logged in as returning user #{user.name}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_from_github(auth_hash)

      if user.save
        flash[:success] = "Logged in as new user #{user.name}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{user.errors.messages}"
        return redirect_to root_path
      end
    end

    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    return redirect_to root_path

  end

  # def login_form
  #   @user = User.new
  # end
  #
  # def login
  #   user = User.find_by(name: params[:user][:name])
  #
  #   if user.nil?
  #     user = User.new(name: params[:user][:name])
  #     if ! user.save
  #       flash[:error] = "unable to login"
  #       redirect_to root_path
  #       return
  #     end
  #     #new user
  #     flash[:welcome] = "Welcome #{user.name}!"
  #   else
  #     #existing user
  #     flash[:welcome] = "Welcome back #{user.name}"
  #   end
  #   session[:user_id] = user.id
  #   redirect_to root_path
  # end
  #
  # def logout
  #   if session[:user_id]
  #     user = User.find_by(id: session[:user_id])
  #     unless user.nil?
  #       session[:user_id] = nil
  #       flash[:notice] = "Goodbye, #{user.name}"
  #     else
  #       session[:user_id] = nil
  #       flash[:notice] = "Error Unknown User"
  #     end
  #   else
  #     flash[:error] = "You must be logged in to logout."
  #   end
  #   redirect_to root_path
  # end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"

    redirect_to root_path
  end
end
