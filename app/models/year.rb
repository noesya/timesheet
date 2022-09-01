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
  has_many :weeks, dependent: :destroy
  has_many :logs
  has_many :themes, -> { distinct }, through: :logs

  # noesya fiscal years go from september to august
  LAST_FISCAL_MONTH = 8

  def self.current
    at_date Date.today
  end

  # janvier 2022 -> 2021
  # septembre 2022 -> 2022
  # janvier 2023 -> 2022
  def self.at_date(date)
    year = date.year
    year -= 1 if date.month <= LAST_FISCAL_MONTH
    with year
  end

  def self.with(number)
    where(number: number).first_or_create
  end

  def days_logged_for_theme(theme)
    logs.where(theme: theme).sum(:days)
  end

  def to_s
    "Exercice #{number} - #{ number + 1 }"
  end
end
