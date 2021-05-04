class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: { message: "cannot be nil" }
  validates :price, presence: { message: "cannot be nil" }
  validates :quantity, presence: { message: "cannot be nil" }
  validates :category, presence: { message: "cannot be nil" }

end
