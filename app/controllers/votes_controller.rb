# frozen_string_literal: true

class VotesController < ApplicationController
  def create
    @vote = Vote.new(params[])
    if @vote.save
      redirect_to work_path
      return
    end
  end
end
