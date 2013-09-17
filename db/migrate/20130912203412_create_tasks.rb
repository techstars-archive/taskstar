class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.date :complete_by
      t.string :team

      t.timestamps
    end
  end
end
