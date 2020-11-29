class ChangeNameToTitleInWorks < ActiveRecord::Migration[6.0]
  def change
    remove_column :works, :name
    add_column :works, :title, :string
  end
end
