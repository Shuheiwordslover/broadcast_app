class AddbodyToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :body, :text

    add_column :broadcasts, :subject, :text



  end
end
