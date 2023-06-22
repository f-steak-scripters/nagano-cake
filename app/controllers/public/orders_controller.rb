class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @deliveries = current_customer.deliveries.all
    @customer = current_customer
  end

  def confirm
    #address_type = params[:order][:address_type].to_i ifで作る比較のときはiとs気をつける
    @order = Order.new(order_params)
  
  end

  def completion
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to 'completion'
    else
      render 'new'
    end
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:method_of_payment, :customer_id, :post_code, :address, :name)
  end

end
