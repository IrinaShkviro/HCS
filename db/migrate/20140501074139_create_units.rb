class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :email
      t.integer :homework
      t.integer :number
      t.float :state
      t.string :comment

      t.timestamps
    end
  end
end
