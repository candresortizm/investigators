class RecognitionInvestigator < ApplicationRecord
  belongs_to :investigator
  belongs_to :announcement
  belongs_to :recognition_level
end
