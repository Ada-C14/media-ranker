class Vote < ApplicationRecord
  validates :user_id, uniqueness: {scope: [:work_id]}

  belongs_to :user
  belongs_to :work

  def format_time
    return(self.created_at.strftime("%b %d, %Y"))
  end
end
