class AddVotecountToUser < ActiveRecord::Migration[6.0]
  def change
    def change
      add_column :users, :vote_count, :integer, default: 0
    end
  end
end
