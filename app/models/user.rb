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
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :logs

  def days_logged(year: nil, theme: nil, week: nil)
    scope = logs
    scope = scope.where(year: year) unless year.nil?
    scope = scope.where(theme: theme) unless theme.nil?
    scope = scope.where(week: week) unless week.nil?
    scope.sum(:days)
  end

  def to_s
    "#{email}"
  end
end
