class Track < ActiveRecord::Base
	TRACK_STATUSES = %w(BONUS REGULAR)

	validates :track_name, :status, :album_id, presence: true
 	validates :status, inclusion: TRACK_STATUSES #, if: -> { status }
	
	belongs_to :album,
		foreign_key: :album_id,
		primary_key: :id,
		class_name: "Album"

end

