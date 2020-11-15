class Vote < ApplicationRecord
  validates :user_id, uniqueness: {scope: :work_id, message: "has already voted for this work"}

  belongs_to :user
  belongs_to :work

  def format_created_at_time
    return(self.created_at.strftime("%b %d, %Y"))
  end
end
