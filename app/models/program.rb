class Program < ActiveRecord::Base
  belongs_to :organization

  scope :friendliness, ->(rate) {where(friendliness_rating: rate)}
  scope :age_range, -> (start_age, end_age){ where("min_age <= ? OR min_age IS null", start_age).where( "max_age >= ? OR max_age IS null", end_age)}
  scope :gender_required, ->(gender){where(gender_req: gender)}
  # scope :health_req, ->(status){where(health_status_req: status)}
  scope :language_needed, ->(language){where(language_req: language)}
  scope :services_offered, ->(request){where("services like ?", request)}

  def self.survey_query(start_age, end_age, friendly = "", language = "", gender = "")
    self.age_range(start_age,end_age).friendliness(friendly).language_needed(language).gender_required(gender)
  end
end
