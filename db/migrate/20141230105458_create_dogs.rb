class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.date :birthday
      t.belongs_to :owner
      t.timestamps
    end
  end
end
