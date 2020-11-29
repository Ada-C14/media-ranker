class WorksController < ApplicationController
    def index
        @works = Work.all

        @albums = @works.where(category: 'album')
        @books = @works.where(category: 'book')
        @movies = @works.where(category: 'movie')
    end

    def show
        @work = Work.find_by(id: params[:id])

        if @work.nil?
            head :not_found
            return
        end 
    end

    def new
        @work = Work.new
    end

    def edit
        @work = Work.find_by(id: params[:id])

        if @work.nil?
            redirect_to works_path
            return
        end
    end

    def update
        @work = Work.find_by(id: params[:id])

        if @work.nil?
            redirect_to works_path
            return
        elsif @work.update(work_params)
            redirect_to work_path(@work)
            return
        else
            render :edit
            return
        end
    end

    def destroy
        work_id = params[:id]
        @work = Work.find_by(id: work_id)

        if @work.nil?
            head :not_found
            return
        end

        @work.destroy

        redirect_to works_path
        return
    end

    def vote
        @work = Work.find_by(id: params[:id])
        if @logged_in_user
            vote = Vote.new(work_id: @work.id, user_id: @logged_in_user.id)
            if vote.save
                flash[:message] = "Successfully voted!"
            else
                flash[:error] = "Could not vote"
                flash[:messages] = vote.errors.messages
            end
        else
            flash[:error] = "You must be logged in to vote for a work"
        end

        redirect_to work_path(@work)
    end

    private
    
    def work_params
        return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
