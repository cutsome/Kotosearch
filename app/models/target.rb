class Target < ApplicationRecord
  has_many :agent_targets
  has_many :agents, through: :agent_targets
end
