class AddProposedPlanToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :proposed_plan, :text
  end
end
