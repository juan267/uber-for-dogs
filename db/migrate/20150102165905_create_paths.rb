class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.float :coord
      t.belongs_to :walk
      t.timestamps
    end
  end
end
