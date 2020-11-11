class AddPublicationYearToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :publication_year, :integer
  end
end
