class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @deliveries = current_customer.deliveries.all
  end

  def confirm
  end

  def completion
  end

  def create
  end

  def index
  end

  def show
  end
end
