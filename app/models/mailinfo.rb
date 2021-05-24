class Mailinfo < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments
end
