class Executive < ActiveRecord::Base
	has_many :memberships,
		foreign_key: :member_id,
		primary_key: :id,
		class_name: "BoardMembership"

	has_many :boards,
		through: :memberships,
		source: :board
end
