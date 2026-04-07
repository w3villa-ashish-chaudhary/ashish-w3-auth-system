class AddPlanFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :plan, :string
    add_column :users, :plan_expires_at, :datetime
    add_column :users, :role, :string
  end
end
