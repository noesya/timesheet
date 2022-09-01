# == Schema Information
#
# Table name: years
#
#  id         :bigint           not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class YearTest < ActiveSupport::TestCase
  test "january" do
    assert_equal  Year.at_date(Date.new(2022, 1, 1)).number,
                  2021
  end

  test "september" do
    assert_equal  Year.at_date(Date.new(2022, 9, 1)).number, 
                  2022
  end
end
