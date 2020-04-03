class Region < ApplicationRecord
  belongs_to :country
  has_many :deptos
  has_many :municipalities, through: :deptos

  def self.get_params(exclude = [])
    params = [
      :id,
      :name,
      :country_id
    ]
  end

end
