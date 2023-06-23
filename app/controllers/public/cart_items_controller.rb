class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'カートの商品数量を変更しました。'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'カートの商品を削除しました。'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カートを空にしました。'
  end

  def create
    # 既存のカートアイテムを探す
    @cart_item = CartItem.find_by(item_id: cart_item_params[:item_id], customer_id: current_customer.id)

    if @cart_item
      # 既存のアイテムがあれば数量を足す
      @cart_item.quantity += cart_item_params[:quantity].to_i
    else
      # 既存のアイテムがなければ新規作成
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
    end

    if @cart_item.save
      redirect_to item_path(@cart_item.item), notice: '商品をカートに追加しました。'
    else
      @item = Item.find(@cart_item.item_id)

      render "public/items/show"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
