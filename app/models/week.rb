# == Schema Information
#
# Table name: weeks
#
#  id          :bigint           not null, primary key
#  ending_at   :date
#  number      :integer
#  starting_at :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  year_id     :bigint           not null, indexed
#
# Indexes
#
#  index_weeks_on_year_id  (year_id)
#
# Foreign Keys
#
#  fk_rails_20b4789a1d  (year_id => years.id)
#
class Week < ApplicationRecord
  include WithLogs

  belongs_to :year
  has_many :themes, -> { distinct }, through: :logs

  MAX_DAYS = 5

  default_scope { order(starting_at: :desc) }

  def self.current
    at_date Date.today
  end

  def self.previous
    current.previous
  end

  def operations_available
    Operation.available_between(starting_at, ending_at)
  end

  def self.at_date(date)
    year = Year.at_date date
    number = date.cweek
    where(year: year, number: number).first_or_create do |week|
      week.starting_at = date.beginning_of_week
      week.ending_at = week.starting_at + 5.days
    end
  end

  def previous
    Week.at_date starting_at - 7.days
  end
  
  def next
    Week.at_date starting_at + 7.days
  end

  def time_remaining_for(user)
    MAX_DAYS - days_logged(user: user, only_workday: false)
  end

  def full_for_user?(user)
    time_remaining_for(user) <= 0
  end

  def to_s
    "Semaine #{number}"
  end

end
