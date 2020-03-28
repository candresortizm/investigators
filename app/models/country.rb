class Country < ApplicationRecord
  has_many :regions
  has_many :deptos, through: :regions
end
