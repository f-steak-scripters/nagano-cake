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
	
	def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def add_tax_price
    (self.price * 1.08).round
  end
end
