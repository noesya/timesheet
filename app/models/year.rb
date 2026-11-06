# == Schema Information
#
# Table name: years
#
#  id         :bigint           not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Year < ApplicationRecord
  include WithLogs

  has_many :weeks, dependent: :destroy
  has_many :themes, -> { distinct }, through: :logs
  has_many :cycles, -> { distinct }, through: :logs
  has_many :users, -> { distinct }, through: :logs

  scope :ordered, -> { order(number: :desc)}

  def self.current
    at_date Date.today
  end

  def self.at_date(date)
    with date.cwyear
  end

  def self.with(number)
    where(number: number).first_or_create
  end

  def cost
    cost = 0
    users.each do |user|
      cost += user.cost(year: self, cycle: cycles)
    end
    cost
  end

  def cir
    cost * User::CIR_RATE
  end

  def to_s
    "Année #{number}"
  end
end
