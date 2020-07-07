class Follower < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :videos, dependent: :destroy
end
