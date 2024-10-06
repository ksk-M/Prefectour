class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :note
      t.date :start_date
      t.date :end_date
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
