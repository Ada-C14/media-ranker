# class VotesController < ApplicationController
#   def upvote
#     # @vote = Vote.find_by(id: params[:id])
#     work = Work.find_by(id: params[:work_id])
#     if work.nil?
#       flash[:warning] = "A problem occurred: Work not found"
#       redirect_to work_path(params[:work_id])
#       return
#     end
#     user = User.find_by(id: session[:user_id])
#     if user.nil?
#       flash[:warning] = "A problem occurred: You must log in to do that"
#       redirect_to work_path(work.id)
#       return
#     end
#     @vote = Vote.new(user_id: user.id, work_id: work.id)
#     p 'NEW VOTE'
#
#     if @vote.save
#       p 'SAVED VOTE'
#       flash[:success] = "Successfully upvoted!"
#       redirect_to :back
#       return
#     else
#       flash[:warning] = "A problem occurred: Could not upvote"
#       @work.errors = @vote.errors
#       p 'ERRORS'
#       p @vote.errors
#       redirect_to work_path(work.id)
#       return
#     end
#   end
# end
