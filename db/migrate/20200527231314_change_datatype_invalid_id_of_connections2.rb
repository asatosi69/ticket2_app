class ChangeDatatypeInvalidIdOfConnections2 < ActiveRecord::Migration[5.0]
  def change
      change_column :connection2s, :invalid_flag, :boolean, default: false, null: false
  end
end
