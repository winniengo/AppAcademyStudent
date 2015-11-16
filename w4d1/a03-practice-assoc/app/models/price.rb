class Price < ActiveRecord::Base
	belongs_to :company,
		foreign_key: :company_id,
		primary_key: :id,
		class_name: "Company"
end
