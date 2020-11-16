class HomepagesController < ApplicationController

  skip_before_action :require_login

  def index

    @spotlights = Work.spotlight

  end

end