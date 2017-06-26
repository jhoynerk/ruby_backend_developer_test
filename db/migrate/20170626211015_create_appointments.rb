class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :seller, foreign_key: { to_table: :users }
      t.belongs_to :buyer, foreign_key: { to_table: :users }
      t.datetime :date
      t.timestamps
    end
  end
end
