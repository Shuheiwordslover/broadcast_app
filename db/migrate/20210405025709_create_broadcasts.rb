class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string :email
      t.string :column1
      t.string :column2
      t.string :column3
      t.string :column4
      t.string :column5
      t.string :column6
      t.string :column7
      t.string :column8
      t.string :column9
      t.string :column10
      t.text :body
      t.text :subject
      t.timestamps null: false
    end
  end
end
