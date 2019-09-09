class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :guests
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
