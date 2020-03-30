class Investigator < ApplicationRecord
  belongs_to :formation_level
  belongs_to :birthplace, class_name: "Municipality"
  belongs_to :current_place, class_name: "Municipality"
  belongs_to :knowledge_speciality
  has_many :recognition_investigators
end
