class ApplicationRecord < ActiveRecord::Base
<<<<<<< HEAD
  self.abstract_class = true
end
=======
    self.abstract_class = true

    def count_vote
        return self.votes.count
    end 
end
  
>>>>>>> 72477d9b986ae4696e0734c67b8c8302d7198149
