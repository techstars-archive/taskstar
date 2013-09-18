class AddIndexToStatus < ActiveRecord::Migration
  def change
    add_index :tasks, :status
  end
end
