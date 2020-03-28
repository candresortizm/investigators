class KnowledgeSpeciality < ApplicationRecord
  belongs_to :knowledge_area
  has_many :investigators
end
