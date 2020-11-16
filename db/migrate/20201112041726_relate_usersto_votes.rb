class RelateUserstoVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :user, index:true
  end
end
