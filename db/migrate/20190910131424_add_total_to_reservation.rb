class AddTotalToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :total, :decimal
  end
end
