class CreatePlanDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_destinations do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
