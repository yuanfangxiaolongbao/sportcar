class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :comments
  belongs_to :category
end
