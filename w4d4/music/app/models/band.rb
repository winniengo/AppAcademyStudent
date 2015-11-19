class Band < ActiveRecord::Base
	validates :name

	has_many :albums,
		foreign_key: :band_id,
		primary_key: :id,
		class_name: "Album",
		dependent: :destory

	has_many :tracks,
		through: :ablums,
		source: :tracks
end