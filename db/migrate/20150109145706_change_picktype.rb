class ChangePicktype < ActiveRecord::Migration
  def change
    change_table :walks do |t|
      t.change :pick_up_time, :datetime
      t.change :drop_off_time, :datetime
    end
  end
end
