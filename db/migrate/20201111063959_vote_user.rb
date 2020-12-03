class VoteUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :work, index:true
    add_reference :votes, :user, index:true
  end
end
