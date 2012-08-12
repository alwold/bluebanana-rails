class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :user
      t.references :event
      t.references :acquiantance
      t.string :acquaintance_first_name
      t.string :acquaintance_last_name
      t.string :acquaintance_source
      t.string :notes
    end
  end
end
