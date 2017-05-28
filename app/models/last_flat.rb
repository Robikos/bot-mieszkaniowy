class LastFlat < ApplicationRecord
  OLX = "olx".freeze

  def self.olx
    find_or_create_by(flat_type: OLX)
  end
end
