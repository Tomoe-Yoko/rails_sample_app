class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }#Procやlambda（もしくは無名関数）と呼ばれるオブジェクトを作成する文法 scope :recent, order(created_at: :desc)
  validates:user_id,presence:true
  validates :content, presence: true, length: { maximum: 255 }
end
