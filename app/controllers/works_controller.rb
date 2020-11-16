class WorksController < ApplicationController
  #Controller Actions are always methods

  WORKS = [
      { title: "Breakfast At Tiffanys", author: "someone", votes: 1, description: "a very average title"},
      { title: "A very good title", author: "2someone", votes: 22, description: "a very average title"},
      { title: "What is sleep?", author: "3someone", votes: 7, description: "a very average title"}
  ]
  def index
    @works = WORKS
  end

  def show
    id = params[:id].to_i
    @work = WORKS[id]

    if @work.nil?
      head :not_found
      return
    end


  end

end
