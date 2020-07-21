class Dancer < ApplicationRecord
    validates :first_dancer, presence: true, uniqueness: true
    validates :second_dancer, presence: true, uniqueness: true
    validates :title, presence: true, uniqueness: true
end
