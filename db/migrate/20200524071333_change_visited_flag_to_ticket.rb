class ChangeVisitedFlagToTicket < ActiveRecord::Migration[5.2]
  def change
      change_column :tickets, :visited_flag, :boolean, default: true, null: false
  end
end
