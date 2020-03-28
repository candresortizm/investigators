class KnowledgeArea < ApplicationRecord
  belongs_to :big_area
  has_many :knowledge_specialities
end
