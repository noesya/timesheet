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

  has_many :years, -> { distinct }, through: :logs
  has_many :users, -> { distinct }, through: :logs

  scope :ordered, -> { order(started_at: :desc) }
  scope :available_between, -> (starting_at, ending_at) { 
    # Cycles overlapping the week (open-ended dates count as unbounded)
    where('started_at <= ? OR started_at IS NULL', ending_at)
    .where('ended_at >= ? OR ended_at IS NULL', starting_at)
    .ordered
  }

  def cost(year: nil)
    @cost = 0
    users.each do |user|
      @cost += user.cost(cycle: self, year: year)
    end
    @cost
  end
  
  def to_s
    "#{name}"
  end

  def to_full_s
    "#{code} #{name}"
  end

end
