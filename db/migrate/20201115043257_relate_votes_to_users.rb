class RelateVotesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :users, index: true
  end
end
