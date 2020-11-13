class Work < ApplicationRecord
  validates :category, :title, presence: true
  validates :publication_year, presence: true,
            inclusion: {
                in: 1800..Date.today.year,
                message:'Please pick a work created from 1800 onward.'
            },
            numericality: {
                only_integer: true,
                message: 'Please enter an integer value for year, from 1800 onward.'
            }

  def self.albums
    where(category: "album")
  end

  def self.books
    where(category: "book")
  end

  def self.movies
    where(category: "movie")
  end

  def self.media_spotlight
    Work.all.limit(1)[0]
  end

  def self.top_ten(category)
    Work.where(category: category).limit(10)
  end

end
