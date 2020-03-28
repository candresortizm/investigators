class CreateRecognitionLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :recognition_levels do |t|
      t.string :id_clas_pr, null: false
      t.string :name_clas_pr, null: false
      t.string :orden_clas_pr, null: false

      t.timestamps
    end
  end
end
