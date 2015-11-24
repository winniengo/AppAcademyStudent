class Tweet < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  validates :body, length: { maximum: 140 }

  belongs_to :user

  has_many :replies,
    dependent: :destroy
end
