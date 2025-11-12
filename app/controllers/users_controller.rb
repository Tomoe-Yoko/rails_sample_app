class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update] # 各アクションの前に実行される [:index, :edit, :update]
  before_action :correct_user,   only: %i[edit update]

  def index
    @users = User.all
  end
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
      reset_session
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) # Strong Parametersを定義するメソッド
  end

  # beforeフィルタ

  # ログイン済みユーザーかどうか確認
  def logged_in_user
      unless logged_in?
        store_location # アクセスしようとしたURLを保存
      flash[:danger] = 'Please log in.'
      redirect_to login_url, status: :see_other
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end
end
