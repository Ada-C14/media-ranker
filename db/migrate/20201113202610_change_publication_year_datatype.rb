class ChangePublicationYearDatatype < ActiveRecord::Migration[6.0]
  def change
    remove_column :works, :publication_year
    add_column :works, :publicaiton_year, :integer
  end
end
