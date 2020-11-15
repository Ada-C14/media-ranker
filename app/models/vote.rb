class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, uniqueness: { scope: :work,
     message: "You can only vote for this work once" }


end
