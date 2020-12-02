class Work < ApplicationRecord
    has_many :votes

    validates :title, presence: true, uniqueness: true
    validates :creator, presence: true
    validates :publication_year, numericality: { only_integer: true }
    validates :description, presence: true

    def self.spotlight
        sorted_work = self.all.sort_by {|work| work.votes.count }
        return sorted_work.last
    end

    def self.sort_albums
        albums = Work.where(category: "album")
        sorted_albums = albums.sort_by {|album| album.votes.count }
        return sorted_albums.reverse
    end

    def self.sort_books
        books = Work.where(category: "book")
        sorted_books = books.sort_by {|book| book.votes.count }
        return sorted_books.reverse
    end

    def self.sort_movies
        movies = Work.where(category: "movie")
        sorted_movies = movies.sort_by {|movie| movie.votes.count }
        return sorted_movies.reverse
    end

end
