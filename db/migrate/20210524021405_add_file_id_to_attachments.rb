class AddFileIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :file_id, :integer
  end
end
