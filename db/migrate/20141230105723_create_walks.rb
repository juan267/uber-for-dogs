class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.integer :distance
      t.integer :calories
      t.integer :pick_up_time
      t.integer :drop_off_time
      t.string :notes
      t.belongs_to :dog
      t.belongs_to :walker
      t.timestamps
    end
  end
end
