class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: {message: "must be unique"}
  validates :category, presence: true


  def self.spotlight
    works = Work.all
    if works.nil?
      puts "Create some works!"
    end
    most_votes = Work.new
    works.each do |work|
      if work.votes.size > most_votes.votes.size
        most_votes = work
      end
    end
    return most_votes
  end

  def self.top(number=10, media)
    number = number.to_i
    return media.max_by(number) { |work| work.votes.count }
  end


end



