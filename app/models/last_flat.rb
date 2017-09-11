class LastFlat < ApplicationRecord
  OLX = "olx".freeze
  TROJMIASTO = "trojmiasto".freeze
  TROJMIASTO_ROOM = "trojmiasto_room".freeze

  def self.olx
    find_or_create_by(flat_type: OLX)
  end

  def self.trojmiasto
    find_or_create_by(flat_type: TROJMIASTO)
  end

  def self.trojmiasto_room
    find_or_create_by(flat_type: TROJMIASTO_ROOM)
  end
end
