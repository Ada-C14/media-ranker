class RemoveDateColumnFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :joined_date
  end
end
