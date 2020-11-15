class Work < ApplicationRecord
  validates :title, presence: true
  validates :media, presence: true

  has_many :votes
  # has_many :users, through: :votes -- which users voted for what?

  def self.spotlight
    return nil if self.nil?
    top_work = self.all
    return top_work.max_by { |work| work.votes.count }
  end

  def self.top_ten(media)
    return nil  if self.nil?

    top_media = Work.where(media: media.to_s)
    unless top_media == []
      return top_media.max_by(10) { |work| work.votes.length }
    end
  end
  #
  # def vote_count
  #   return self.votes.count
  # end

end
