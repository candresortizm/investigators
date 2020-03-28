class Depto < ApplicationRecord
  belongs_to :region
  has_one :country, through: :region
  has_many :municipalities
end
