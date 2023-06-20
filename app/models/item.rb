class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  has_one_attached :image
  
  validates :name, presence: true
	validates :description, presence: true
	validates :genre_id, presence: true
	validates :price, presence: true
	validates :price, numericality: { only_integer: true }
end
