class WorksController < ApplicationController
  def index
    @works = Work.order # list all works in order
  end
end
