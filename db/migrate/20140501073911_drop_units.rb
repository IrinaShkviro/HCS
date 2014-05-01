class DropUnits < ActiveRecord::Migration
  def change
	drop_table :Units
  end
end
