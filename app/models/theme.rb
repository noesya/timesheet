# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theme < ApplicationRecord

    default_scope { order(:name) }

    def to_s
        "#{ name }"
    end
end
