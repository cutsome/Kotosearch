class Leisure < ApplicationRecord
  has_many :owner_leisures
  has_many :owners, through: :owner_leisures
end
