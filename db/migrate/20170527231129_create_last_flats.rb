class CreateLastFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :last_flats do |t|
      t.string :type
      t.string :title
    end
  end
end
