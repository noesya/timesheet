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
#  year_id     :bigint           not null
#
# Indexes
#
#  index_weeks_on_year_id  (year_id)
#
# Foreign Keys
#
#  fk_rails_...  (year_id => years.id)
#
class Week < ApplicationRecord
  belongs_to :year
  has_many :logs, dependent: :destroy
  has_many :themes, -> { distinct }, through: :logs

  MAX_DAYS = 5

  default_scope { order(starting_at: :desc) }

  def self.current
    at_date Date.today
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

  def logs_for(user)
    logs.where(user: user)
  end
  
  def non_empty_logs_for(user)
    logs_for(user).reject { |log| log.days.zero? }
  end

  def days_logged_for(user)
    logs_for(user).sum(:days)
  end

  def time_remaining_for(user)
    MAX_DAYS - days_logged_for(user)
  end

  def days_logged_for_theme(theme)
    logs.where(theme: theme).sum(:days)
  end

  def days_logged
    logs.sum(:days)
  end

  def to_s
    "Semaine #{number}"
  end

end
