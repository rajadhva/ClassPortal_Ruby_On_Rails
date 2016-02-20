class Reference < ActiveRecord::Base
  belongs_to :course
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :description, presence: true # Make sure the owner's name is present.
end
