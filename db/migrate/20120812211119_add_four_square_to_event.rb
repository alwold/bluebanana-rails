class AddFourSquareToEvent < ActiveRecord::Migration
  def change
    add_column :events, :foursquare_venue_id, :string
  end
end
