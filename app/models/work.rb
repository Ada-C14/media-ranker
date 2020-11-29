class Work < ApplicationRecord
    has_many :votes

    def self.top_ten(category)
        where(category: category).order(vote_cout: desc).limit(10)
    end

    def self.top_albums
        top_ten("album")
    end

    def self.top_books
        top_ten("book")
    end
end
