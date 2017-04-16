class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @orders = current_user.orders
  end

  def create
    order = Order.new(user_id: User.find(params[:user_id].to_i).id)
    @briefcase.contents.each do |power_id, quantity|
      order.powers << Power.find(power_id)
      order.order_powers.last.power_quantity = quantity
    end

    if order.save
      session[:briefcase] = nil
      flash[:notice] = "Your order was successfully placed. You ordered #{pluralize(order.quantity, "power")}."
      redirect_to order_path(order)
    else
    end
  end

  def show
    @order = Order.find(params[:id])
    @powers = @order.powers
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: "Cancelled")
    redirect_to powers_path
  end

end
