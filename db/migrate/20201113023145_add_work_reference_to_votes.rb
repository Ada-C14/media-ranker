class AddWorkReferenceToVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :work, null: false, foreign_key: true
  end
end
