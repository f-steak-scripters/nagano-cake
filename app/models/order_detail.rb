class OrderDetail < ApplicationRecord
  enum status: { impossible: 0, waiting: 1, making: 2, completation: 3 }
  belongs_to :item
  belongs_to :order
  def subtotal
    price * quantity
  end
end
