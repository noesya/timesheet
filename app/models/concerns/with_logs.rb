module WithLogs
  extend ActiveSupport::Concern

  included do
    has_many :logs, dependent: :nullify
  end

  def logs_filtered(cycle: nil, theme: nil, user: nil, year: nil, week: nil)
    selected_logs = logs.on_workday
    selected_logs = selected_logs.where(cycle: cycle) if cycle.present?
    selected_logs = selected_logs.where(theme: theme) if theme.present?
    selected_logs = selected_logs.where(user: user) if user.present?
    selected_logs = selected_logs.where(year: year) if year.present?
    selected_logs = selected_logs.where(week: week) if week.present?
    selected_logs.ordered
  end

  def days_logged(**args)
    logs_filtered(**args).count
  end

end
