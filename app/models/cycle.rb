# == Schema Information
#
# Table name: cycles
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  ended_at    :date
#  name        :string
#  started_at  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cycle < ApplicationRecord
  include WithLogs

  scope :ordered, -> { order(started_at: :desc)}
  
  def to_s
    "#{name}"
  end

end
