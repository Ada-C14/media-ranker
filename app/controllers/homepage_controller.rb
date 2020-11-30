class HomepageController < ApplicationController
    def index
        @works = Work.all

        @top_albums = Work.best_albums
        @top_books = Work.best_books
    end
end
