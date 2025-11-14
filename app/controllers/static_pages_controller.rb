class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.microposts.order(created_at: :desc)
      # 本当のチュートリアルでは feed メソッドを使うけど、
      # まずは「自分の投稿だけ」でOKにしておく
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  


end
