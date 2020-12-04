class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true

  def self.spotlight
    spotlight_for_all_works = Work.all.sample
    return spotlight_for_all_works
  end
end

