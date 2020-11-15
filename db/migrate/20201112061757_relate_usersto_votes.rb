class RelateUserstoVotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :votes, :user_id
    add_reference :votes, :user, index: true
  end
end
