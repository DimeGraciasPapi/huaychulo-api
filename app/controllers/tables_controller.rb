class TablesController < ApplicationController
  skip_before_action :validate_admin_user, only: %i[ index update ]
  before_action :set_table, only: %i[ update destroy ]

  def index
    @tables = Table.all.sort_by{ |table| table[:id] }
    render json: @tables
  end

  def create
    @table = Table.new(table_params)

    if @table.save
      render json: @table, status: :created
    else
      render json: { error: @table.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: { error: @table.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @table.destroy

    render json: { success: "La mesa fue eliminada" }
  end

  private

  def table_params
    params.permit(:pavilion, :code, :chairs, :image, :available)
  end

  def set_table
    @table = Table.find(params[:id])
  end
end
