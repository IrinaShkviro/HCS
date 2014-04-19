class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.integer :group
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
