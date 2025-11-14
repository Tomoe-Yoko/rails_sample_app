class Micropost < ApplicationRecord
  belongs_to :user

  default_scope lambda {
    order(created_at: :desc)
  } # Procやlambda（もしくは無名関数）と呼ばれるオブジェクトを作成する文法 scope :recent, order(created_at: :desc)
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  has_one_attached :image
  # 画像のサイズ制限
  validate :image_size

  private

  def image_size
    return unless image.attached?

    return unless image.blob.byte_size > 5.megabytes

    errors.add(:image, 'should be less than 5MB')
  end
end
