class UsersController < ApplicationController
  include JwtHelper
  before_action :set_user, only: %i[ update ]
  skip_before_action :verify_authenticity_token

  # GET /user/logout
  def logout
    cookies.delete(:jwt_token)
    render "redirect_home_unauthenticated", layout: false
  end

  # POST /user/forgot
  def forgot_password
    render status: :internal_server_error, plain: "Recurso ainda não implementado"
  end

   # GET /user/login
  def login
    begin
      @user = User.find_by(email: params[:email])

      if @user.password != params[:password]
        return render status: :bad_request, plain: "Senha invalida!"
      end

      token = generate_jwt_token(user_data)
      cookies[:jwt_token] = { value: token, expires: 2.hour.from_now, httponly: true }
      render "redirect_home_authenticated", layout: false
    rescue => e
      render status: :internal_server_error, plain: "Erro interno"
    end
  end

  # POST /users
  def create
    if params[:password] != params[:repeat_password]
      return render status: :bad_request, plain: "Senha não são iguais!"
    end

    begin
      @user = User.new(user_params)

      if @user.save
        token = generate_jwt_token(user_data)
        cookies[:jwt_token] = { value: token, expires: 2.hour.from_now, httponly: true }
        render "redirect_home_authenticated", layout: false, status: :created
      else 
        render status: :unprocessable_entity, plain: "Falha no processamento dos dados, tente novamente"
      end
    rescue => e
      render status: :internal_server_error, plain: "Erro interno"
    end
  end

  # PATCH/PUT /users/1
  def update
    begin
      if @user.update(user_params)
        token = generate_jwt_token(user_data)
        cookies[:jwt_token] = { value: token, expires: 2.hour.from_now, httponly: true }
        render "redirect_home_authenticated", layout: false
      else
        render status: :unprocessable_entity, plain: "Falha no processamento dos dados, tente novamente"
      end
    rescue => e
      render status: :internal_server_error, plain: "Erro interno"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:name, :email, :password)
    end

    def user_data  
      {
          id: @user.id,
          name: @user.name,
          email: @user.email,
          activated: @user.activated,
          blocked: @user.blocked,
          created_at: @user.created_at,
          updated_at: @user.updated_at
      }
    end
end
