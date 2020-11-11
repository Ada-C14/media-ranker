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
    
    private
    
    def work_params
        return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
