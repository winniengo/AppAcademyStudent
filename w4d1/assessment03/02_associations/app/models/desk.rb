# == Schema Information
#
# Table name: desks
#
#  id         :integer          not null, primary key
#  model      :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Desk < ActiveRecord::Base
	belongs_to :owner,
		foreign_key: :owner_id,
		primary_key: :id,
		class_name: "Senator"
end
