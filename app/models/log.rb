# == Schema Information
#
# Table name: logs
#
#  id         :bigint           not null, primary key
#  days       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  theme_id   :bigint           not null, indexed
#  user_id    :bigint           not null, indexed
#  week_id    :bigint           not null, indexed
#  year_id    :bigint           not null, indexed
#
# Indexes
#
#  index_logs_on_theme_id  (theme_id)
#  index_logs_on_user_id   (user_id)
#  index_logs_on_week_id   (week_id)
#  index_logs_on_year_id   (year_id)
#
# Foreign Keys
#
#  fk_rails_312648668a  (year_id => years.id)
#  fk_rails_8fc980bf44  (user_id => users.id)
#  fk_rails_b596f8ee81  (theme_id => themes.id)
#  fk_rails_e298d07143  (week_id => weeks.id)
#
class Log < ApplicationRecord
  belongs_to :user
  belongs_to :week
  belongs_to :year
  belongs_to :theme

  before_validation :prepare

  scope :on_workday, -> { joins(:theme).where(themes: { workday: true }) }

  def increment
    self.days += 1
    remaining = Week::MAX_DAYS - week.days_logged_for(user)
    self.days = 0 if remaining <= 0
    save
  end

  protected

  def prepare
    self.year = week.year
  end
end
