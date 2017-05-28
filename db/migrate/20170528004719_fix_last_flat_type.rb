class FixLastFlatType < ActiveRecord::Migration[5.0]
  def change
    rename_column :last_flats, :type, :flat_type
  end
end
