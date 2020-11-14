class Work < ApplicationRecord
  validates :title, presence: true
  validates :media, presence: true

  has_many :votes
  # has_many :users, through: :votes -- which users voted for what?

  def self.spotlight
    works = Work.all
    works.max_by { |work| work.votes.count }
  end

  def self.top_ten(media)
    return nil  if self.nil?

    all_results = Work.where(media: media.to_s)
    unless all_results == []
      return all_results.max_by(10) { |work| work.votes.count }
    else
      return []
    end
  end

  def vote_count
    return self.votes.count
  end

end
