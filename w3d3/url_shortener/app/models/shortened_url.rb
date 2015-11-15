class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :submitter_id, :presence => true
  validates :short_url, :uniqueness => true

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'User'

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user


  def self.random_code
    short_url = SecureRandom.base64(16)
    while self.exists?(:short_url => short_url)
      short_url = SecureRandom.base64(16)
    end
    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    if user.premium || user.num_submissions < 5
      self.create!(:long_url => long_url, :short_url => self.random_code, :submitter_id => user.id)
    end
  end
  0
  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques(num_minutes)
    visitors.where("visits.created_at >= ?", num_minutes.minutes.ago).count
  end
end
