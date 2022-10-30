class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create
  skip_before_action :validate_admin_user, only: %i[ destroy create ]
  
  def create
    user = User.find_by(document: params[:document])
    if user&.authenticate(params[:password])
      user.regenerate_token
      render json: user.as_json(except: :password_digest)
    else
      respond_unauthorized("Usuario o contraseña no válidos")
    end
  end

  def destroy
    current_user.invalidate_token
    render json: { success: "Se cerro la sesión con éxito" }
  end
end
