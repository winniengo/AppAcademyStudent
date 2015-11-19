# == Schema Information
#
# Table name: parties
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  color           :string(255)
#  ideology_id     :integer
#  party_leader_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Party < ActiveRecord::Base
	has_many :senators,
		foreign_key: :party_id,
		primary_key: :id,
		class_name: "Senator"

	belongs_to :party_leader,
		foreign_key: :party_leader_id,
		primary_key: :id,
		class_name: 'Senator'

	belongs_to :ideology,
		foreign_key: :ideology_id,
		primary_key: :id,
		class_name: 'Ideology'
end

