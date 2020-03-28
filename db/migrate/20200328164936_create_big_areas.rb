class CreateBigAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :big_areas do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
