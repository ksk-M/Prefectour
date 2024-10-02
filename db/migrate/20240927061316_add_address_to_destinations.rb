class AddAddressToDestinations < ActiveRecord::Migration[6.1]
  def change
    add_column :destinations, :address, :string
  end
end
