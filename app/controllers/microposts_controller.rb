class MicropostsController < ApplicationController
  def destroy
    @micropost=current_user.microposts.find(params[:id])
    @micropost.destroy
    flash[:success]="Micropost deleted"
    redirect_to request.referrer || root_url
  end
end
