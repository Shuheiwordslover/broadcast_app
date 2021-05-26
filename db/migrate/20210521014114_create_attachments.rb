class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.string :URL
      t.integer :mailinfo_id

      t.timestamps null: false
    end
  end
end
