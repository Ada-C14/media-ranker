class ChangePublicationYearTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :works, :publicaiton_year, :publication_year
  end
end
