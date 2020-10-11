class AddSentFlagToSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :sent_flag, :boolean, default: false, null: false
  end
end
