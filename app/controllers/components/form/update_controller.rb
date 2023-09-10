class Components::Form::UpdateController < ApplicationController
  include JwtHelper

  def index
    token = cookies[:jwt_token]
    if token
      user_data = decode_jwt_token(token)
      if user_data
        @name = user_data['name']
        @email = user_data['email']
        @id = user_data['id']
        render "index", layout: false
      else
        render status: :unauthorized, plain: "Token inválido ou expirado"
      end
    else
      render status: :unauthorized, plain: "Token inválido ou expirado"
    end 
  end
end