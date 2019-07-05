class UserController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def create
    p params[:username]
  end

  private
    def post_params
      params.require(:user).permit(:fullname, :username, :password)
    end
end
