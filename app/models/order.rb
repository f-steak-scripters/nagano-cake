class Order < ApplicationRecord
  enum method_of_payment:{ card:0,bank:1}
  enum status: { waiting: 0, paid_up: 1, making: 2, preparing: 3 ,shipped:4}
end
