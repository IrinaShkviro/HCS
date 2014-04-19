class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :number
      t.integer :homework
      t.text :condition
      t.datetime :time

      t.timestamps
    end
  end
end
