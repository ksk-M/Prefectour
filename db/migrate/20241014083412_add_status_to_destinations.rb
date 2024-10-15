class AddStatusToDestinations < ActiveRecord::Migration[6.1]
  def change
    add_column :destinations, :status, :string, default: "未訪問"
  end
end
