class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :note
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true
      t.boolean :is_private

      t.timestamps
    end
  end
end
