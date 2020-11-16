class ChangePubDateToInt < ActiveRecord::Migration[6.0]
  def change
    remove_column(:works, :publication_date)
    add_column(:works, :publication_date, :integer)
  end
end
