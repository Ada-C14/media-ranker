class RemoveUsersAndWorksToVotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :votes, :user
    remove_column :votes, :work


  end
end
