class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  #def albums
      album = self.all.collect {|work| work.category == "album"}
  puts album
  #end

      # Work.each do |work|
      # if self.category == "album"
      #   album = work
      # return album

end



