class WorksController < ApplicationController
  def index
    @works = Works.all
  end
end
