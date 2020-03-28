class Investigator < ApplicationRecord
  belongs_to :formation_level
  belongs_to :municipality
  belongs_to :knowledge_speciality
end
