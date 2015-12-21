class Bench < ActiveRecord::Base
  validates :lat, :lng, :description, presence: true
  validates :lat, :lng, numericality: true
  validates :lat, uniqueness: { scope: :lng }

  def self.in_bounds(params)
    self.select do |bench|
      bench.lat.between?(bounds["southWest"]["lat"].to_f, bounds["northEast"]["lat"].to_f) &&
      bench.lng.between?(bounds["southWest"]["lng"].to_f, bounds["northEast"]["lng"].to_f)
    end
  end
end
