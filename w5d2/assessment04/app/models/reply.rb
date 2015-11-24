class Reply < ActiveRecord::Base
  validates :body, :tweet_id, presence: true
  validates :body, length: { maximum: 140 }

  belongs_to :tweet
end
