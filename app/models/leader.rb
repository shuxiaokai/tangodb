class Leader < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
