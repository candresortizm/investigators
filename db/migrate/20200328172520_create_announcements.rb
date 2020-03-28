class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements do |t|
      t.string :name, null: false
      t.string :id_announcement, null:false
      t.date :date_announcement, null: false

      t.timestamps
    end
  end
end
