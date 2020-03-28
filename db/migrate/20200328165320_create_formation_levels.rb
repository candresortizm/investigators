class CreateFormationLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :formation_levels do |t|
      t.string :name, null:false
      t.string :id_level, null:false
      t.integer :order_level, null:false

      t.timestamps
    end
  end
end
