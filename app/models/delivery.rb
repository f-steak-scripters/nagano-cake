class Delivery < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  
  def full_deliveries
    '〒' + post_code + ' ' + address + ' ' + name
  end
  
end
