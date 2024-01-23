class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :name
      t.integer :amount
      t.string :status
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
