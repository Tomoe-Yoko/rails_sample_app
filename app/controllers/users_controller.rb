class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #  debugger
  end

  def new
    # Userインスタンスを作成し、@userに代入せよ
    @user = User.new
  end

  def create
    @user = User.new(user_params) # 実装は終わっていないことに注意!
    if @user.save
      # 保存の成功をここで扱う。
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) # 「許可したデータだけを取り出す」Railsの安全機構
  end
end
