class WorksController < ApplicationController
  def index
    @works = WORKS
  end
end
