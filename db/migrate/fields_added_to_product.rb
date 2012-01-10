class FieldsAddedToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :best_seller, :boolean
    add_column :products, :featured, :boolean
    add_column :products, :new_product, :boolean
  end

  def self.down
    remove_column :products, :new_product
    remove_column :products, :featured
    remove_column :products, :best_seller
  end
end
