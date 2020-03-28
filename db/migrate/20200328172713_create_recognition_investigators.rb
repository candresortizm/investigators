class CreateRecognitionInvestigators < ActiveRecord::Migration[6.0]
  def change
    create_table :recognition_investigators do |t|
      t.references :investigator, null: false, foreign_key: true
      t.references :announcement, null: false, foreign_key: true
      t.references :recognition_level, null: false, foreign_key: true
      t.float :investigator_age, null: false

      t.timestamps
    end
  end
end
