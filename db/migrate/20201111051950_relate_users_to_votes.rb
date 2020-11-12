class RelateUsersToVotes < ActiveRecord::Migration[6.0]
  def change
    # this migration will create a user_id column and appropriate index.
    add_reference :votes, :user, index: true
  end
end
