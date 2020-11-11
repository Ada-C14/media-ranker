class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show

  end

  def new
    @work = Work.new
  end

  def create

  end

end
