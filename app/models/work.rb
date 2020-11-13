class Work < ApplicationRecord
  validates :title, presence: true
  validates :media, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.top_ten

  end

  def self.spotlight
    works = Work.all
  end
end
