class CreateKnowledgeSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :knowledge_specialities do |t|
      t.references :knowledge_area, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.string :id_area, null: false, index:true

      t.timestamps
    end
  end
end
