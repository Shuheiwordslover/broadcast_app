class Attachment < ActiveRecord::Base
  mount_uploader :file_name, AttachmentUploader
  belongs_to :mailinfo, foreign_key: "id"
end
