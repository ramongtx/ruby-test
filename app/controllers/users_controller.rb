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
    begin
      u = User.create(user_params)
      if u.save
        render nothing: true, status: :created
      else
        render json: {"error"=>"Failed to save user"}
      end
    rescue => error
      render json: {"error" => error.message}
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

  def user_params
    params.permit(:username, :email, :password, :social_id)
  end
end
