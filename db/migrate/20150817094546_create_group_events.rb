class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.date :start_date
      t.integer :duration
      t.date :end_date
      t.boolean :delete
      t.boolean :published

      t.timestamps create_date: false
    end
  end
end
