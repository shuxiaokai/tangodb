# == Schema Information
#
# Table name: dancers
#
#  id            :bigint           not null, primary key
#  first_dancer  :string
#  second_dancer :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Dancer < ApplicationRecord
    validates :first_dancer, presence: true, uniqueness: true
    validates :second_dancer, presence: true, uniqueness: true
    validates :title, presence: true, uniqueness: true
end
