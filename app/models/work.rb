class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: [:category]}
  has_many :votes
  has_many :users, through: :votes

  def self.select_spotlight
    works = self.all
    spotlight_votes = works.max_by{|work| work.votes.length}.votes.length
    if spotlight_votes == 0
      return nil
    else
      top_works = works.select{|work| work.votes.length == spotlight_votes}
      top_work = top_works.sort_by{|work| work.title}[0]
    end
    return top_work
  end

  def self.select_top_ten(media)
    media = media[0..-2]
    works = self.where(category: media)
    if works.length > 0 
      spotlight_votes = works.max_by{|work| work.votes.length}.votes.length
      if spotlight_votes == 0
        return nil
      else
        top_works = works.sort_by{|work| [-work.votes.length, work.title]}[0..9]
        return top_works
      end
    end
  end

end
