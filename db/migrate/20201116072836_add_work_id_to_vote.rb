class AddWorkIdToVote < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :work, null: false, foreign_key: true, index: true
    add_reference :votes, :user, null: false, foreign_key: true, index: true
  end
end
