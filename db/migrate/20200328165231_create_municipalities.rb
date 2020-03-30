class CreateMunicipalities < ActiveRecord::Migration[6.0]
  def change
    create_table :municipalities do |t|
      t.references :depto, null: false, foreign_key: true
      t.string :name, null: false
      t.string :dane_code
      t.string :ubic_res

      t.timestamps
    end
  end
end
