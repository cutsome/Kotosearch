class Photo < ApplicationRecord

  belongs_to :agent
  belongs_to :owner

  validates :agent_id, presence: true
  validates :owner_id, presence: true
  validates :photos, presence: true
end
