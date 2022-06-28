# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theme < ApplicationRecord
  has_many :logs

  default_scope { order(:name) }

  def days_logged
    logs.sum(:days)
  end

  def to_s
      "#{ name }"
  end
end
