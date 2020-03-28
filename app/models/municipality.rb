class Municipality < ApplicationRecord
  belongs_to :depto
  has_many :investigators
end
