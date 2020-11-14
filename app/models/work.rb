require 'pry'

class Work < ApplicationRecord
  validates :creator, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}

  def self.spotlight
    return self.all.sample
  end

  def votes
    return rand(1..10)
  end

  def self.top_ten(media)
    if self.count > 10
      return self.where(category: media).sample(10)
    else
      return self.where(category: media).sample(self.count / 2)
    end
  end
end
