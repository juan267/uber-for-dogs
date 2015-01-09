class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.integer :distance
      t.integer :calories
      t.datetime :pick_up_time
      t.datetime :drop_off_time
      t.string :notes
      t.belongs_to :dog
      t.belongs_to :walker
      t.string :status, :default => "schedule"
      t.timestamps
    end
  end
end
