class Work < ApplicationRecord
    has_many :votes
    has_many :users, through: :votes


    def upvote(user)
        # create a work from user through this work
        vote = Vote.new(user: user, work: self)
        vote.save
    end
    
end
