class CreateCouponingTable < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|

      t.string :name
      t.string :description
      t.text :metadata
      
      t.string :alpha_code
      t.string :alpha_mask
      t.string :digit_code
      t.string :digit_mask
      
      t.string :category_one
      t.float :amount_one, :default => 0.00
      t.float :percentage_one, :default => 0.00
      
      t.string :category_two
      t.float :amount_two, :default => 0.00
      t.float :percentage_two, :default => 0.00
      
      t.date :expiration
      t.integer :how_many, :default => 1

      t.integer :redemptions_count, :integer, :default => 0
      
      t.timestamps
    end

    create_table :redemptions do |t|
      t.references :coupon
      t.references :redeemable, :polymorphic => true
      t.text :savings_hash

      t.timestamps
    end
    
    add_index :coupons, :alpha_code
    add_index :coupons, :digit_code
    
  end

  def self.down
    drop_table :coupons
    drop_table :redemptions
  end
end
