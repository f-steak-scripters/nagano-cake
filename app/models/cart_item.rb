class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :quantity, presence: true

  def price_with_tax
    (item.price * 1.08).round
  end

  def subtotal
    price_with_tax * quantity
  end

end
