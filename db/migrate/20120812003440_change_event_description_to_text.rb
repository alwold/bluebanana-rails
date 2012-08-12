class ChangeEventDescriptionToText < ActiveRecord::Migration
  def change
    remove_column :events, :description
    add_column :events, :description, :text
  end
end
