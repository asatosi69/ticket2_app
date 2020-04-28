class AddInvalidFlagToConnections < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :invalid_flag, :boolean, default: false, null: false
  end
end
