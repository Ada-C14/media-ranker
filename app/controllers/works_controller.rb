class WorksController < ApplicationController
  #Controller Actions are always methods

  WORKS = [
      { title: "Breakfast At Tiffanys", author: "someone"},
      { title: "A very good title", author: "2someone"},
      { title: "What is sleep?", author: "3someone"}
  ]
  def index
    @works = WORKS
  end


end
