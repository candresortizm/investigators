class Region < ApplicationRecord
  belongs_to :country
  has_many :deptos
  has_many :municipalities, through: :deptos
end
