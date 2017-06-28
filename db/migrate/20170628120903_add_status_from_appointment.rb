class AddStatusFromAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :status, :boolean, null: true, default: nil
  end
end
