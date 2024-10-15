class AddStatusToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :status, :string, default: "未実行"
  end
end
