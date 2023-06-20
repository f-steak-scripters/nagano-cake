class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :genre_id, :price, :is_sales )
  end
  
end






#   before_action :set_product, only: [:show, :edit, :update]
#   before_action :set_genres, only: [:new, :edit, :index, :create, :update]

#   def new
#     @item = Item.new
#   end

#   def create
#     @item = Item.new(itemt_params)
#     if @item.save
#       flash[:notice] = "商品を登録しました"
#       redirect_to admin_product_path(@product)
#     else
#       render :new
#     end
#   end

#   def index
#     @items = Item.all.page(params[:page]).per(10)
#   end

#   def show
#   end

#   def edit
#   end

#   def update
#     if @item.update(item_params)
#       flash[:success] = "商品内容をを変更しました"
#       redirect_to admin_item_path(@item)
#     else
#       render :edit
#     end
#   end

#   private

#   def item_params
#     params.require(:item).permit(:name, :image, :explanation,
#       :genre_id, :price, :is_sales)
#   end

#   def set_genres
#     @genres = Genre.where(is_valid: true)
#   end
  
# end