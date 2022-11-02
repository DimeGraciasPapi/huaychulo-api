class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[ create ]
  skip_before_action :validate_admin_user, only: %i[ show update create destroy ]

  def index
    @users = User.all;
    render json: @users.map{ |user| user.as_json(except: %i[ password_digest token ]) }
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(except: :password_digest), status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user.as_json(except: :password_digest)
  end

  def update
    if current_user.update(user_params)
      render json: current_user.as_json(except: :password_digest)
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy

    render json: { success: "El usuario fue eliminado" }
  end

  private

  def user_params
    params.permit(:user_type, :name, :last_name, :document, :password, :intake, :document_type)
  end
end
