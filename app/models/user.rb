# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
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

  def self.from_omniauth(auth)
    User.where(email: auth.uid.downcase).first_or_create do |u|
      u.password = "#{Devise.friendly_token[0,20]}!"
    end
  end

  def days_logged(year: nil, theme: nil, week: nil)
    scope = logs
    scope = scope.where(year: year) unless year.nil?
    scope = scope.where(theme: theme) unless theme.nil?
    scope = scope.where(week: week) unless week.nil?
    scope.sum(:days)
  end

  def human
    email.split('@').first.gsub('.', ' ').titleize
  end

  def to_s
    "#{human}"
  end
end
