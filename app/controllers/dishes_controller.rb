class DishesController < ApplicationController
  skip_before_action :authorize, only: %i[ index show ]
  skip_before_action :validate_admin_user, only: %i[ index show ]
  before_action :set_dish, only: %i[ update destroy show ]
  
  def index
    @dishes = Dish.all.sort_by{ |dish| dish[:id] }
    @dishes = @dishes.map{ |dish| merge_category_name(dish) }

    render json: @dishes
  end

  def show
    render json: merge_category_name(@dish)
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      render json: merge_category_name(@dish), status: :created
    else
      render json: { error: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @dish.update(dish_params)
      render json: merge_category_name(@dish)
    else
      render json: { error: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @dish.destroy

    render json: { success: "El platillo fue eliminado" }
  end

  private

  def merge_category_name(dish)
    dish.as_json.merge(category_name: dish.category.name)
  end

  def dish_params
    params.permit(:category_id, :name, :price, :quantity, :description, :waiting_time, :image)
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end
end
