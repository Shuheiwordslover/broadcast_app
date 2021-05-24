class Attachment < ActiveRecord::Base
  mount_uploader :file_name_path, AttachmentUploader
  belongs_to :mailinfo, foreign_key: "mail_id"
end
