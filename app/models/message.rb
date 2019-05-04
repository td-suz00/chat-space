class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :text, presence: true, unless: :image?

  mount_uploader :image, ImageUploader
end
