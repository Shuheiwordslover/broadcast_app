class AddSmtpinfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string, default: ""
    add_column :users, :port, :integer, default: 25
    add_column :users, :domain, :string, default: ""
    add_column :users, :user_name, :string, default: ""
    add_column :users, :smtp_password, :string, default: ""
    add_column :users, :authentication, :string, default: ""
    add_column :users, :enable_starttls_auto, :boolean, default: true
  end
end
