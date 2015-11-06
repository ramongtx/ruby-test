require 'socialId'

class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    users = User.all
    render json: users
  end

  def show
    begin
      user = User.find(params[:id])
      render json: user
    rescue => error
      render json: {"error" => error.message}
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy!
      render nothing: true
    rescue => error
      render json: {"error" => error.message}
    end
  end

  def create
    u = User.create(user_params)
    if u.save
      render nothing: true, status: :created
    else
      render json: {"error"=>"Failed to save user"}
    end
  end

  def update
    begin
      user = User.find(params[:id])
      user.update(user_params)
      if user.save
        render nothing: true
      else
        render json: {"error"=>"Failed to save user"}
      end
    rescue => error
      render json: {"error" => error.message}
    end
  end

  def login
    if params[:token]
      session[:loginToken] = params[:token]
      render nothing: true, status: :ok
    else
      response = SocialId.emailLogin(params[:email],params[:password])
      if response['error']
        render plain: response['error_description'], status: response.code
      else
        session[:loginToken] = response['login_token']
        session[:loginEmail] = params[:email]
        render nothing: true, status: :ok
      end
    end
  end

  def user_params
    params.permit(:username, :email, :password, :social_id)
  end
end
