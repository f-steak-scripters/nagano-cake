class OrderDetail < ApplicationRecord
  enum status: {
    '着手不可': 0,
    '制作待ち': 1,
    '制作中': 2,
    '制作完了': 3
  }
  belongs_to :item
  belongs_to :order
  def subtotal
    price * quantity
  end
end
