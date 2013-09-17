class ChangeTeamToTeamId < ActiveRecord::Migration
  def change
    rename_column :tasks, :team, :team_id
  end
end
