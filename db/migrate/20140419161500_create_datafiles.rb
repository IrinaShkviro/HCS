class CreateDatafiles < ActiveRecord::Migration
  def change
    create_table :datafiles do |t|
      t.string :name
      t.text :comment
      t.integer :size

      t.timestamps
    end
  end
end
