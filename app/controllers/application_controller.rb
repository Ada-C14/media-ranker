class ApplicationController < ActionController::Base
<<<<<<< HEAD
=======
    def current_user
        @current_user = User.find_by(id: session[:user_id])
        unless @current_user
          flash[:error] = "You must be logged in to see this page"
          redirect_to root_path
          return
        end
        return @current_user
      end

    def require_login
        if current_user.nil?
          flash[:error] = "Please log in first to continue"
          redirect_to login_path
        end
      end
>>>>>>> 72477d9b986ae4696e0734c67b8c8302d7198149
end
