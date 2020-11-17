class ChangeDefaulVotesTo0 < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:works, :votes, 0)
  end
end
