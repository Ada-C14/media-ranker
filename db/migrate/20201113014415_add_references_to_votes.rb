class AddReferencesToVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :user, index: true
    add_reference :votes, :work, index: true
    remove_column :votes, :count, :integer
  end
end
