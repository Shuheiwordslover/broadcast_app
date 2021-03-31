class AddDeletedAtToUsers < ActiveRecord::Migration
  def up
    change_column_null :users, :delete_at,false, 0
    change_column_null :users, :delete_at,:datetime, default:0
  end

  def down
    change_column_null :users, :delete_at, true, nil
    change_column :users, :delete_at, :datetime, default: nil

  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
