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
  test "01/01/2022 in 2021" do
    assert_equal  Week.at_date(Date.new(2022, 1, 1)).year.number, 
                  2021
  end

  test "01/01/2022 correct starting_at" do
    assert_equal  Week.at_date(Date.new(2022, 1, 1)).starting_at, 
                  Date.new(2021, 12, 27)
  end

  test "01/09/2022 in 2022" do
    assert_equal  Week.at_date(Date.new(2022, 9, 1)).year.number, 
                  2022
  end

  test "01/09/2022 correct starting_at" do
    assert_equal  Week.at_date(Date.new(2022, 9, 1)).starting_at, 
                  Date.new(2022, 8, 29)
  end

  test "01/12/2022 in 2022" do
    assert_equal  Week.at_date(Date.new(2022, 12, 1)).year.number, 
                  2022
  end

  test "01/12/2022 correct starting_at" do
    assert_equal  Week.at_date(Date.new(2022, 12, 1)).starting_at, 
                  Date.new(2022, 11, 28)
  end

end
