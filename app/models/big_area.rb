class BigArea < ApplicationRecord
  has_many :knowledge_areas
  has_many :knowledge_specialities, through: :knowledge_areas
end
