class LastFlat < ApplicationRecord
  OLX = "olx".freeze

  def self.olx
    find_or_create_by(type: OLX)
  end
end
