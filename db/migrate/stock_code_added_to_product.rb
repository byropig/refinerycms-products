class StockCodeAddedToProduct < ActiveRecord::Migration
  def self.up
		add_column :products, :stock_code, :string
  end

  def self.down
		remove_column :products, :stock_code
  end
end
