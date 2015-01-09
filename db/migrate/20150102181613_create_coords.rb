class CreateCoords < ActiveRecord::Migration
  def change
    create_table :coords do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.belongs_to :walk
      t.timestamps
    end
  end
end
