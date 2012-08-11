class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventbrite_id
      t.string :title
      t.string :description
      t.timestamp :start
      t.timestamp :end
    end
  end
end
