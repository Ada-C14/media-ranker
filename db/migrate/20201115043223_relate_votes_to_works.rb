class RelateVotesToWorks < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :work, foreign_key: true
  end
end
