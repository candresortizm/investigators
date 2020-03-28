class CreateDeptos < ActiveRecord::Migration[6.0]
  def change
    create_table :deptos do |t|
      t.references :region, null: false, index: true, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
