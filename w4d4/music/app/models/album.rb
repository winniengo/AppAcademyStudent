class Album < ActiveRecord::Base
	ALBUM_STATUSES = %w(LIVE STUDIO)

	validates :album_name, :status, :band_id, presence: true
	validates :status, inclusion: ALBUM_STATUSES #, if: -> { status }

	belongs_to :band,
		foreign_key: :band_id,
		primary_key: :id,
		class_name: "Band"

	has_many :tracks,
		foreign_key: :album_id,
		primary_key: :id,
		class_name: "Track",
		dependent: :destroy

	# def band_name
	# 	band.name
	# end

end