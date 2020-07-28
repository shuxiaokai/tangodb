class Videotype < ApplicationRecord

    has_many :videos,  dependent: :destroy
    
end
