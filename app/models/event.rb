class Event < ApplicationRecord

    has_many :videos,  dependent: :destroy
    
end
