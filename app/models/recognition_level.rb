class RecognitionLevel < ApplicationRecord
  has_many :recognition_investigators
  has_many :investigators, through: :recognition_investigators
end
