class AddDiscountToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :discount, :decimal
  end
end
