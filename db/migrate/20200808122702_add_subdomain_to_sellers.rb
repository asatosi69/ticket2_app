class AddSubdomainToSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :subdomain, :string
  end
end
