class PermalinkReflex < ApplicationReflex
    def filter 
      #byebug
      params[element[:name].to_sym] = element.values.present? ? element.value : element.value
    end
  end
  