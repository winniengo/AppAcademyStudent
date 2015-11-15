class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true

  has_many :submitted_urls,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'

  has_many :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visited_urls,
    through: :visits,
    source: :shortened_url

  def num_recent_submissions(num_minutes)
    submitted_urls.where("created_at > ?", num_minutes.minutes.ago).count
  end

  def num_submissions
    submitted_urls.count
  end
end
