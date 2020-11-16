class RemovePublicationYearFromWorks < ActiveRecord::Migration[6.0]
  def change
    remove_column :works, :publication_year, :date
  end
end
