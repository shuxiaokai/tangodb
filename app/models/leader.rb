class Leader < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :videos,    dependent: :destroy
    has_many :followers, dependent: :destroy
end
