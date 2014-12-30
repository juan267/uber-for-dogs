class CreateWalkers < ActiveRecord::Migration
  def change
    create_table :walkers do |t|
      t.sting :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash
  end
end