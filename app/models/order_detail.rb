class OrderDetail < ApplicationRecord
  enum status: {'着手不可': 0,'製作待ち': 1,'製作中': 2,'製作完了': 3}
  belongs_to :item
  belongs_to :order
  def subtotal
    price * quantity
  end
end
