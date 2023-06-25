class Public::DeliveriesController < ApplicationController
  def index
    @delivery=Delivery.new
    @deliveries = Delivery.all
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id=current_customer.id
    if @delivery.save
    redirect_to deliveries_path, notice: '配送先を作成しました。'
    else
    redirect_to deliveries_path, alert: '配送先の作成に失敗しました。'
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
  if @delivery.update(delivery_params)
    redirect_to deliveries_path, notice: '配送先を更新しました。'
  else
    redirect_to edit_delivery_path(@delivery), alert: '配送先の更新に失敗しました。'
  end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path, notice: '配送先を削除しました。'
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :post_code, :address)
  end

end
