class WorksController < ApplicationController

  def index
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book") 
  end

  def show
  end
end
