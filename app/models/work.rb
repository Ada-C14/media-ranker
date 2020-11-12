class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true

  def spotlight

  end

  def top_ten

  end

end
