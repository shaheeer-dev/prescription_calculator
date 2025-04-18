class CreatePrescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :prescriptions do |t|
      t.decimal :budget, default: 0.00, precision: 10, scale: 2, null: false
      t.string :status

      t.timestamps
    end
  end
end

