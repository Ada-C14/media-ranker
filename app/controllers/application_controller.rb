class ApplicationController < ActionController::Base
    before_action :find_user

    def find_user
        if session[:user_id]
            @logged_in_user = User.find_by(id: session[:user_id])
        end
    end

end
