# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string
#  workday    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theme < ApplicationRecord
  include WithLogs

  default_scope { order(:name) }

  def to_s
      "#{ name }"
  end
end
