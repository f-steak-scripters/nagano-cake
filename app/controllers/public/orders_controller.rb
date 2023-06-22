class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @deliveries = current_customer.deliveries.all
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @postage = 800
    @subtotal = 0
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @subtotal += cart_item.subtotal
    end
    @total = @postage + @subtotal

        if params[:order][:address_type] == "1"
        @order.post_code = current_customer.post_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name

        elsif params[:order][:address_type] == "2"
        ship = Delivery.find(params[:order][:customer_id])
        @order.post_code = ship.post_code
        @order.address = ship.address
        @order.name = ship.name

        elsif params[:order][:address_type] = "3"
        @order.post_code = params[:order][:shipping_post_code]
        @order.address = params[:order][:shipping_address]
        @order.name = params[:order][:shipping_name]
        else
            render 'new'
        end

        @order.customer_id = current_customer.id
  end


  def completation
  end

  def create
   @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @order.save

        current_customer.cart_items.each do |cart_item|
          @order_detail = OrderDetail.new
          @order_detail.item_id = cart_item.item_id
          @order_detail.quantity = cart_item.quantity
          @order_detail.price = (cart_item.item.price*1.08).floor
          @order_detail.order_id =  @order.id
          @order_detail.save
        end

        current_customer.cart_items.destroy_all #カートの中身を削除
        redirect_to completation_orders_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:method_of_payment, :customer_id, :post_code, :address, :name ,:postage ,:billing_amount)
  end

end
