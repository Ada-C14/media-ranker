class Work < ApplicationRecord
    has_many :votes

    def self.by_category(category)
        self.where(category: category).order(vote_count: desc)
    end

    def self.media_spotlight
        Work.all.order(vote_count: :desc).first
    end

    def self.top_ten_books
        work = Work.all
        books = []
        work.each do |work|
          if work.category == "book"
            books << work
          end
        end
        top_ten = books.sort_by{|work| work.votes.count}.reverse
        return top_ten[0...10]
    end

    def self.top_ten_albums
        work = Work.all
        albums = []
        work.each do |work|
          if work.category == "album"
            albums << work
          end
        end
        top_ten = albums.sort_by{|work| work.votes.count}.reverse
        return top_ten[0...10]
    end
end
