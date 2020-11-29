class ChangeDateToYearInWorks < ActiveRecord::Migration[6.0]
  def change
    remove_column :works, :publication_date
    add_column :works, :publication_year, :integer
  end
end
