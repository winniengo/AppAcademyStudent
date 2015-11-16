class WatchListItem < ActiveRecord::Base
	belongs_to :watch_list,
		foreign_key: :watch_list_id,
		primary_key: :id,
		class_name: "WatchList"

	belongs_to :company,
		foreign_key: :company_id,
		primary_key: :id,
		class_name: "Company"

	has_many :users,
		through: :watch_list,
		source: :user
end
