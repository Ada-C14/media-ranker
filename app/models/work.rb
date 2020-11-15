class Work < ApplicationRecord
    has_many :votes
    has_many :users, through: :votes

    validates :title, presence: true, uniqueness: { scope: :category}

    def self.find_by_category(category)
        Work.where(category: :category).left_joins(:votes).group(:id).order("COUNT(votes) DESC, TITILE ASC")
    end

    def self.spotlight
        Work.left_joins(:votes).group(:id).order("COUNT(votes) DESC, TITILE ASC").limit(1).first
    end

end

# def upvote(user)
    #     # create a work from user through this work
    #     vote = Vote.new(user: user, work: self)
    #     vote.save
    # end
