class OrdersController < ApplicationController
  skip_before_action :validate_admin_user, only: %i[ index show create ]
  before_action :set_order, only: %i[ show update destroy ]

  def index
    @orders = Order.all.sort_by{ |order| order[:id] }
    @orders = @orders.map{ |order| merge_items(order) }
    render json: @orders
  end

  def show
    render json: merge_items(@order)
  end

  def create
    @order = Order.new(order_params)
    if !params[:items] || params[:items].size.zero?
      render json: { error: "Items is required" }, status: :unprocessable_entity
    else
      if @order.save
        record = []

        params[:items].each do |item|
          dish = Dish.find(item["dish_id"])

          order_detail = OrderDetail.new(
            dish: dish,
            order: @order,
            quantity: item["quantity"],
            sub_total: dish.price * item["quantity"]
          )

          if order_detail.save
            record.push(true)
            newQuantity = order_detail.dish.quantity - order_detail.quantity
            order_detail.dish.update(quantity: newQuantity <= 0 ? 0 : newQuantity)
          else 
            record.push(false)
          end
        end

        if record.find{ |e| e == false }.nil?
          total = @order.order_details.map{ |el| el.sub_total }.reduce(:+)
          @order.update(total: total)
          @order.user.update(intake: @order.user.intake + total)
          @order.table.update(available: false)

          render json: merge_items(@order)
        else
          @order.destroy

          render json: { error: "Algo salio mal al leer los items" }, status: :unprocessable_entity
        end
      else
        render json: { error: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    if @order.update(order_params)
      render json: merge_items(@order)
    else
      render json: { error: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy

    render json: { success: "La orden fue eliminada" }
  end

  private

  def merge_items(order)
    order.as_json.merge(items: order.order_details)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:user_id, :table_id, :total, :status)
  end
end
