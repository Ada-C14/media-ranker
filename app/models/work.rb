class Work < ApplicationRecord
    has_many :votes

    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, numericality: { only_integer: true }

    def self.spotlight
        sorted_work = self.all.sort_by {|work| work.votes.count }
        return sorted_work.last
    end

    def self.sort_albums
        sorted_albums = self.all.select {|work| work.category == "album" }
        return sorted_albums
    end

    def self.sort_books
        sorted_books = self.all.select {|work| work.category == "book" }
        return sorted_books
    end

    def self.top_books
        top_books = sort_books.sort_by {|work| work.votes.count }

        top_ten_books = top_books.last(10).reverse

        return top_ten_books
    end

    def self.top_albums
        top_albums = sort_albums.sort_by {|work| work.votes.count }

        top_ten_albums = top_albums.last(10).reverse

        return top_ten_albums
    end

end
