class Song < ApplicationRecord
    validates :genre,  presence: true
    validates :title,  presence: true
    validates :artist, presence: true

    has_many  :videos
end
