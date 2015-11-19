# == Schema Information
#
# Table name: committee_memberships
#
#  id           :integer          not null, primary key
#  senator_id   :integer
#  committee_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CommitteeMembership < ActiveRecord::Base
	belongs_to :senator,
		foreign_key: :senator_id,
		primary_key: :id,
		class_name: "Senator"

	belongs_to :committee,
		foreign_key: :committee_id,
		primary_key: :id,
		class_name: "Committee"

	has_one :chairperson,
		through: :committee,
		source: :chairperson
end

