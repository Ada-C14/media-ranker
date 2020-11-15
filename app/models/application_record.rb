class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def count_vote
        return self.count.votes.count
    end 
end
  