class Band < ActiveRecord::Base
	validates :name, presence: true

	has_many :albums,
		foreign_key: :band_id,
		primary_key: :id,
		class_name: "Album",
		dependent: :destroy

	has_many :tracks,
		through: :ablums,
		source: :tracks
end