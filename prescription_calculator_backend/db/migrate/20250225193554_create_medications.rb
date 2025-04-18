class CreateMedications < ActiveRecord::Migration[7.1]
  def change
    create_table :medications do |t|
      t.string :name, null: false
      t.decimal :unit_price, default: 0.00, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :medications, :name, unique: true
  end
end
