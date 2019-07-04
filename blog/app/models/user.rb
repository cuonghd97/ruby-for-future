class User < ApplicationRecord
  def new
  end

  def create
    @user = User.new(post_params)
  end

  private
    def post_params
      params.require(:user).permit(:fullname, :username, :password)
    end
end
