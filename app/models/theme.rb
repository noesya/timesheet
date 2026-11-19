# == Schema Information
#
# Table name: themes
#
#  id            :bigint           not null, primary key
#  color         :string
#  name          :string
#  with_research :boolean          default(FALSE)
#  workday       :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Theme < ApplicationRecord
  include WithLogs

  scope :with_research, -> { where(with_research: true) }
  default_scope { order(:name) }

  def to_s
      "#{ name }"
  end
end
