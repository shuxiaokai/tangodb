class PermalinkReflex < ApplicationReflex
    def filter 
      binding.pry
      params[element[:name].to_sym] = element.values&.present? ? element.values : element.value
    end
  end
  