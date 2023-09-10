class HomeController < ApplicationController
  include JwtHelper

  def index
    token = cookies[:jwt_token]
    if token
      user_data = decode_jwt_token(token)
      if user_data
        @name = user_data['name']
        render "home_authenticated"
      else
        render "home"
      end
    else
      render "home"
    end
  end

  def index_authenticated
    token = cookies[:jwt_token]
    if token
      user_data = decode_jwt_token(token)
      if user_data
        @name = user_data['name']
        render "home_authenticated", layout: false
      else
        render status: :unauthorized, plain: "Token inválido ou expirado"
      end
    else
      render "home", layout: false
    end
  end

  def index_unauthenticated
      render "home", layout: false
  end
end