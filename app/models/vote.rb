class Vote < ApplicationRecord
  validates :user, uniqueness: {scope: :work, message: "has already voted for this work"}
  #do I also have to validate the reverse?

  belongs_to :user
  belongs_to :work

end
