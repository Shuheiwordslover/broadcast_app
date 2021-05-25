class Mailinfo < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :attachments
  accepts_nested_attributes_for :attachments
end
