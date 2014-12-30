class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :password_hash
      t.timestamps
    end
  end
end
