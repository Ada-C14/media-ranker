class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, uniqueness: { scope: :work,
                                    message: "Only one user per work, please" }
end
