class LastFlat < ApplicationRecord
  OLX = "olx".freeze
  TROJMIASTO = "trojmiasto".freeze

  def self.olx
    find_or_create_by(flat_type: OLX)
  end

  def self.trojmiasto
    find_or_create_by(flat_type: TROJMIASTO)
  end
end
