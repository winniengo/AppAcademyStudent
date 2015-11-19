# == Schema Information
#
# Table name: committees
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  mandate        :string(255)
#  chairperson_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Committee < ActiveRecord::Base
	has_many :memberships,
		foreign_key: :committee_id,
		primary_key: :id,
		class_name: "CommitteeMembership"

	has_many :senators,
		through: :memberships,
		source: :senator

	belongs_to :chairperson,
		foreign_key: :chairperson_id,
		primary_key: :id,
		class_name: "Senator"
end

