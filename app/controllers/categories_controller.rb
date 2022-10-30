class CategoriesController < ApplicationController
  skip_before_action :authorize, only: :index
  skip_before_action :validate_admin_user, only: :index
  before_action :set_category, only: %i[ update destroy ]

  def index
    @categories = Category.all.sort_by{ |category| category[:id] }
    render json: @categories
  end

  def create
    @category = Category.new(name: params[:name])

    if @category.save
      render json: @category, status: :created
    else
      render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(name: params[:name])
      render json: @category
    else
      render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    
    render json: { success: "La categoría fue eliminada" }
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
