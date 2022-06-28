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
require "test_helper"

class WeekTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
