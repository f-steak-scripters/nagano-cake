class Admin::OrdersDetailsController < ApplicationController
  def update
    @order_details = OrderDetail.find(params[:id])
    @order_details.update(order_deteail_params)
    redirect_to admin_order_path(@order_details.order_id)
  end

  private

  def order_deteail_params
    params.require(:order_detail).permit(:status)
  end

end
