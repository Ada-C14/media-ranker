class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, uniqueness: { scope: :work, message: "One user_id per work" }

  def user_votes_table_row
    work = self.work
    return [work.title, work.creator, work.publication, work.category.capitalize, self.created_at, work.id]
  end
end
