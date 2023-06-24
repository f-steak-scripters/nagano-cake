class Admin::OrdersDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
    @order_details = OrderDetail.where(order_id: @order.id)
    @order_detail.update(order_deteail_params)

    if @order_details.all? { |order_detail| order_detail.status == "製作完了" }
      @order.update(status: "発送準備中")
    elsif @order_detail.status == "製作中"
      @order.update(status: "製作中")
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_deteail_params
    params.require(:order_detail).permit(:status)
  end

end
