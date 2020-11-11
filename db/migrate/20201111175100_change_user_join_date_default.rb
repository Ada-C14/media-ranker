class ChangeUserJoinDateDefault < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :join_date, Date.today.to_s
  end

  def down
    change_column_default :users, :join_date, nil
  end
end
