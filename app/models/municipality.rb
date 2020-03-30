class Municipality < ApplicationRecord
  belongs_to :depto
  has_many :investigators_birthplace, class_name: "Investigator", foreign_key: "birthplace_id"
  has_many :investigators_current, class_name: "Investigator", foreign_key: "current_place_id"
end
