class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def count_vote
        return self.votes.count
    end 
end
  
