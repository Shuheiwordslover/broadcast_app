class CreateMailinfos < ActiveRecord::Migration
  def change
    create_table :mailinfos do |t|
      t.integer :user_id
      t.integer :mail_id
      t.text :body
      t.text :subject

      t.timestamps null: false
    end
  end
end
