class Board < ActiveRecord::Base
	belongs_to :company,
		foreign_key: :company_id,
		primary_key: :id,
		class_name: "Company"

	has_many :memberships,
		foreign_key: :board_id,
		primary_key: :id,
		class_name: "BoardMembership"

	has_many :members,
		through: :memberships,
		source: :member

	has_one :exchange,
		through: :company,
		source: :exchange	
end
