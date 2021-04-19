class AddUserIdToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :user_id, :integer
  end
end
