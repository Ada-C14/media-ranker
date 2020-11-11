class WorksController < ApplicationController
    def index
        @works = Work.all
    end

    def show
        @work = Work.find_by(id: params[:id])

        if @work.nil?
            head :not_found
            return
        end 
    end


    private
    
    def work_params
        return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
