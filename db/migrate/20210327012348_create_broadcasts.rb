class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string :file

      t.timestamps null: false
    end
  end
end
