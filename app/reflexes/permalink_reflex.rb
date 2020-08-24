class PermalinkReflex < ApplicationReflex
    def filter 
      #byebug
      params[element[:name].to_sym] = element.value
    end
  end
  