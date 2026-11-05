# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  cost_per_day           :integer          default(0)
#  email                  :string           default(""), not null, uniquely indexed
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           uniquely indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :trackable
  devise  :database_authenticatable, :recoverable, :rememberable,
          :validatable, :omniauthable, omniauth_providers: [:saml]

  has_many :logs

  default_scope { order(:last_name, :first_name) }

  def self.from_omniauth(auth)
    User.where(email: auth.uid.downcase).first_or_create do |u|
      u.password = "#{Devise.friendly_token[0,20]}!"
    end
  end

  def days_logged(year: nil, theme: nil, week: nil)
    scope = logs.on_workday
    scope = scope.where(year: year) unless year.nil?
    scope = scope.where(theme: theme) unless theme.nil?
    scope = scope.where(week: week) unless week.nil?
    scope.sum(:days)
  end

  def percent_logged(year: nil, theme: nil, week: nil)
    days_logged = days_logged(year: year, theme: theme, week: week)
    days_total = days_logged(year: year, theme: nil, week: week)
    (100.0 / days_total * days_logged).round
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def to_s
    first_name.blank? ? email : "#{first_name} #{last_name}"
  end
end
