class Work < ApplicationRecord
    has_many :votes

    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, numericality: { only_integer: true }

    def self.spotlight
        sorted_work = self.all.sort_by {|work| work.votes.count }
        return sorted_work.last
    end

    def self.top_books
        sorted_books = self.all.select {|work| work.category == "book" }
        top_books = sorted_books.sort_by {|work| work.votes.count }

        top_ten_books = top_books.last(10).reverse

        return top_ten_books
    end

    def self.top_albums
        sorted_albums = self.all.select {|work| work.category == "album" }
        top_albums = sorted_albums.sort_by {|work| work.votes.count }

        top_ten_albums = top_albums.last(10).reverse

        return top_ten_albums
    end


    # def self.list_albums
    #     albums = @works.select{ |work| work[:category] == "album"}

        # all_albums = albums.each do |album|
        #     print album.title
        #     print album[:creator]
        #     print album[:publication_year]
        # end

        # return albums
    # end

end
