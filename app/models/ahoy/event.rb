class Ahoy::Event < AhoyRecord
  include Ahoy::QueryMethods

  belongs_to :visit
  belongs_to :user, optional: true
  
  class << self
    def youtube_ids_of_most_viewed_videos_by_month
      Ahoy::Event.where("time > ?", 30.days.ago)
                .where(name: "Video View")
                .select("properties AS youtube_id, count(properties) AS occurrences")
                .group("properties")
                .order("occurrences DESC")
                .map(&:youtube_id)
    end
  end
end
