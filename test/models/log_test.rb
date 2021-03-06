# == Schema Information
#
# Table name: logs
#
#  id         :bigint           not null, primary key
#  days       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  theme_id   :bigint           not null
#  user_id    :bigint           not null
#  week_id    :bigint           not null
#  year_id    :bigint           not null
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
#  fk_rails_...  (theme_id => themes.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (week_id => weeks.id)
#  fk_rails_...  (year_id => years.id)
#
require "test_helper"

class LogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
