class CreateKnowledgeAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :knowledge_areas do |t|
      t.references :big_area, null: false, index: true, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
