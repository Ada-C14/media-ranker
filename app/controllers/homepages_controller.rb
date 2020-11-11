class HomepagesController < ApplicationController

  def index
    @users = User.all
    @works = Work.all
    @votes = Vote.all
  end
end
