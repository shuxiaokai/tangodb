# == Schema Information
#
# Table name: videotypes
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  related_keywords :string
#

class Videotype < ApplicationRecord

    has_many :videos,  dependent: :destroy
    
end
