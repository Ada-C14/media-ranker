class HomepageController < ApplicationController
  def index
    @works = Work.all
    @users = User.all
  end
end