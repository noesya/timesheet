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
  include WithLogs

  CIR_RATE = 0.4

  devise  :database_authenticatable, :recoverable, :rememberable,
          :validatable, :omniauthable, omniauth_providers: [:saml]

  default_scope { order(:last_name, :first_name) }

  def self.from_omniauth(auth)
    User.where(email: auth.uid.downcase).first_or_create do |u|
      u.password = "#{Devise.friendly_token[0,20]}!"
    end
  end

  def percent_logged(year: nil, week: nil)
    days_logged = days_logged(year: year, week: week, operation: Operation.all)
    days_total = days_logged(year: year, week: week)
    (100.0 / days_total * days_logged).round
  end

  def cost(**args)
    days_logged(**args) * cost_per_day
  end

  def cir(**args)
    cost(**args) * CIR_RATE
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def to_s
    first_name.blank? ? email : "#{first_name} #{last_name}"
  end
end
