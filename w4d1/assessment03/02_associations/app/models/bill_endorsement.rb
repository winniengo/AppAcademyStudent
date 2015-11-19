# == Schema Information
#
# Table name: bill_endorsements
#
#  id         :integer          not null, primary key
#  bill_id    :integer
#  senator_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class BillEndorsement < ActiveRecord::Base
	belongs_to :bill,
		foreign_key: :bill_id,
		primary_key: :id,
		class_name: "Bill"

	belongs_to :senator,
		foreign_key: :senator_id,
		primary_key: :id,
		class_name: "Senator"
end
