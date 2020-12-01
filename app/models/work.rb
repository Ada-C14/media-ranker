class Work < ApplicationRecord
    has_many :votes

    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, numericality: { only_integer: true }

    def self.spotlight
        sorted_work = self.all.sort_by {|work| work.votes.count }
         # self.order('RANDOM()').limit(1).first
        return sorted_work.last
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
