# == Schema Information
#
# Table name: fighters
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  power      :string           not null
#  history    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fighter < ActiveRecord::Base
  validates :name, :power, :history, presence: true
end
