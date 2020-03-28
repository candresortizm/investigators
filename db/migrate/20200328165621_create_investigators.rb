class CreateInvestigators < ActiveRecord::Migration[6.0]
  def change
    create_table :investigators do |t|
      t.datetime :birthday, null:false
      t.string :gender, null: false
      t.references :birthplace, null: false, index: true, foreign_key: {to_table: :municipalities}
      t.references :current_place, null: false, index: true, foreign_key: {to_table: :municipalities}
      t.references :formation_level, null: false, foreign_key: true
      t.references :knowledge_speciality, null:false, foreign_key: true

      t.timestamps
    end
  end
end
