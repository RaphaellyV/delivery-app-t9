class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :check_admin, only: [:new, :create]
  
  def index
    @all_orders = Order.all.order(id: :desc)
    @pending_orders = Order.pending.order(id: :desc)
    @orders_delivered_on_time = Order.delivered_on_time.order(id: :desc)
    @orders_delivered_late = Order.delivered_late.order(id: :desc)
  end

  def new
    @order = Order.new
  end

  def create
    order_params = params.require(:order).permit(:delivery_address, :delivery_city, :delivery_state, :delivery_postal_code, 
                                                  :recipient, :recipient_cpf, :recipient_email, :recipient_phone_number, 
                                                  :pick_up_address, :pick_up_city, :pick_up_state, :pick_up_postal_code, 
                                                  :sku, :height, :width, :length, :weight, :distance)
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: t(:order_registration_success)
    else
      flash.now[:alert] = t(:order_registration_error)

      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])

    if @order.pending?
      @quotations = @order.generate_quotations
      @shipping_options = @order.search_possible_shipping_options
    end
  end 

  def search
    @tracking_code = params[:query]
    @order = Order.find_by(tracking_code: @tracking_code)
  end

  def deliver
    @order = Order.find(params[:id])
    
    @order.detailed_order.update(delivery_date: Time.now)


    if @order.detailed_order.delivery_date <= @order.detailed_order.estimated_delivery_date
      @order.vehicle.available!
      @order.delivered_on_time!
      redirect_to @order, notice: t(:order_delivered_on_time)

    else
      redirect_to  new_order_delayed_order_url(@order), alert: t(:order_delivered_late)
    end  
  end
end