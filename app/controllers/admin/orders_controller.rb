class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order.update(order_params)

    if @order.status == "入金確認"
      @order_details.each do |order_detail|
        order_detail.update(status: "製作待ち")
      end
    end

    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:method_of_payment, :customer_id, :post_code, :address, :name ,:postage ,:billing_amount,:status)
  end



end
