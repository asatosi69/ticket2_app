class AddEndFlagtoKind < ActiveRecord::Migration[5.2]
  def change
      add_column :kinds, :end_flag, :boolean, default: false, null: false
  end
end
