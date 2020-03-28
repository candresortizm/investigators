class CreateMunicipalities < ActiveRecord::Migration[6.0]
  def change
    create_table :municipalities do |t|
      t.references :depto, null: false, foreign_key: true
      t.string :name, null: false
      t.string :dane_code, null: false
      t.string :ubic_res, null: false

      t.timestamps
    end
  end
end
