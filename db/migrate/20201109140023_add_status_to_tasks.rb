class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :Status, :string
  end
end
