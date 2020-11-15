class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # check that user hasn't voted before
  #GOOGLE rails model validation uniqueness scope
  #validates :work, :uniqueness => {:scope => :user}
  validates :work_id, uniqueness: {scope: user_id}

end
