class Work < ApplicationRecord
  validates :title, presence: true
  validates :media, presence: true

  has_many :votes
  # has_many :users, through: :votes -- which users voted for what?

  def self.top_ten

  end

  def self.spotlight
    works = Work.all
  end
end
