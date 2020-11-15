class Work < ApplicationRecord
  has_many :votes
  # has_many :upvoters, through: :votes
  validates :title, presence: true, uniqueness: {message: "must be unique"}


  def spotlight

  end


end



