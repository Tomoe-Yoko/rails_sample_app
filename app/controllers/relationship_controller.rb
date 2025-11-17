class RelationshipController < ApplicationController

def create
  user=User.find(params[:followed_id]) # アクションが起きたフォローされる相手
  current_user.follow(user)
  redirect_to user
end

def destroy
  relationship=Relationship.find(params[:id]) #Relationship の id を受け取る
  user=relationship.followed 
  current_user.unfollow(user)
  redirect_to user
end
end
