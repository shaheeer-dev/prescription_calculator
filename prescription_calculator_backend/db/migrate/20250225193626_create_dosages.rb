class CreateDosages < ActiveRecord::Migration[7.1]
  def change
    create_table :dosages do |t|
      t.references :medication, null: false, foreign_key: true
      t.string :amount, null: false
      t.string :frequency, null: false
      t.integer :default_duration, null: false

      t.timestamps
    end
  end
end
